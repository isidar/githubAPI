//
//  GithubAPIManager.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

class GithubAPIManager {
    
    enum FetchingError: Error {
        case plain(Error)
        case other(String)
    }
    
    typealias RepositoriesFetchingCompletion = (Result<[Repository], FetchingError>) -> Void
    
    static func fetchRepositories(fromAccount account: String, completion: RepositoriesFetchingCompletion?) {
        let request = "https://api.github.com/users/\(account)/repos"        
        guard let url = URL(string: request) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion?(.failure(.plain(error)))
                return
            }
            guard let data = data else {
                completion?(.failure(.other("data response equals nil")))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                if let errorMessage = json as? [String: Any],
                   let message = errorMessage["message"] as? String {
                    completion?(.failure(.other(message)))
                }
                
                guard let arrayOfRepositories = json as? [[String: Any]] else {
                    completion?(.failure(.other("missing array of repositories")))
                    return
                }
                
                let repositoriesCount = arrayOfRepositories.count
                
                var repositories: [Repository] = []
                repositories.reserveCapacity(repositoriesCount)
                
                for notParsedRepository in arrayOfRepositories {
                    let name = notParsedRepository["name"] as? String ?? ""
                    let description = notParsedRepository["description"] as? String
                    let urlHtml = notParsedRepository["html_url"] as? String
                    let forksCount = notParsedRepository["forks_count"] as? Int
                    let starCount = notParsedRepository["stargazers_count"] as? Int
                    
                    let owner = notParsedRepository["owner"] as? [String: Any]
                    let author = owner?["login"] as? String
                    
                    fetchTags(fromAccount: account, ofRepository: name) { result in
                        let tags = try? result.get()
                        
                        let newRepository = Repository(
                            name: name,
                            descriptionInfo: description,
                            URL: urlHtml,
                            forks: forksCount,
                            stars: starCount,
                            author: author,
                            tags: tags
                        )
                        repositories.append(newRepository)
                        
                        if repositories.count == repositoriesCount {
                            completion?(.success(repositories))
                        }
                    }
                }
                
            } catch let jsonError {
                completion?(.failure(.plain(jsonError)))
            }
            }.resume()
    }
    
    /// Fetches tags(topics) by a given repository name
    static private func fetchTags(fromAccount account: String, ofRepository repository: String, completion: ((Result<[String], FetchingError>) -> Void)?) {
        let tagsRequest = "https://api.github.com/repos/\(account)/\(repository)/topics"
        guard let url = URL(string: tagsRequest) else {
            completion?(.failure(.other("bad url")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion?(.failure(.plain(error)))
                return
            }
            
            guard let data = data else {
                completion?(.failure(.other("data response equals nil")))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                guard let dictionary = json as? [String: Any],
                    let arrayOfTags = dictionary["names"] as? [String] else {
                        completion?(.failure(.other("parsing error")))
                        return
                }
                
                completion?(.success(arrayOfTags))
            } catch let jsonError {
                completion?(.failure(.plain(jsonError)))
            }
            }.resume()
    }
    
}
