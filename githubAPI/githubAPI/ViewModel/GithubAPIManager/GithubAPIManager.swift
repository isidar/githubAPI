//
//  GithubAPIManager.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

class GithubAPIManager {
    // MARK: - Model
    
    var repositories = [Repository]()
    
    // MARK: - Data source
    
    var accountName: String
    
    // MARK: - Inits
    
    init(accountName: String, completion: @escaping ([Repository], String?) -> ()) {
        self.accountName = accountName
        
        fetchRepositories(completion: completion)
    }
    
    // MARK: - Deinit
    
    deinit { print("\n  GithubAPIManager deallocated") }
    
    // MARK: - Other functions
    
    /// Fetches all available repositories from certain account (by account name)
    private func fetchRepositories(completion: @escaping ([Repository], String?) -> ()) {
        let request = "https://api.github.com/users/\(accountName)/repos"
        
        if let url = URL(string: request) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion([Repository](), error.debugDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    if let errorMessage = json as? [String: Any] {
                        if let message = errorMessage["message"] as? String {
                            completion([Repository](), message)
                        }
                    }
                    
                    if let arrayOfRepositories = json as? [[String: Any]] {
                        let repositoriesCount = arrayOfRepositories.count
                        
                        for repository in arrayOfRepositories {
                            let name = repository["name"] as! String
                            let description = repository["description"] as? String
                            let urlHtml = repository["html_url"] as! String
                            let forksCount = repository["forks_count"] as! Int
                            let starCount = repository["stargazers_count"] as! Int
                            
                            let owner = repository["owner"] as! [String: Any]
                            let author = owner["login"] as! String
                            
                            self.fetchTagsOf(repositoryName: name) { tags in
                                let newRepository = Repository(
                                    name: name,
                                    descriptionInfo: description ?? "",
                                    URL: urlHtml,
                                    forks: String(forksCount),
                                    stars: String(starCount),
                                    author: author,
                                    tags: tags
                                )
                                self.repositories.append(newRepository)

                                if self.repositories.count == repositoriesCount {
//                                    if let repositories = self.repositories {
                                        completion(self.repositories, nil)
//                                    }
                                }
                            }
                        }
                    }
                } catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
    /// Fetches tags(topics) by gievn repository name
    private func fetchTagsOf(repositoryName: String, completion: @escaping ([String]) -> ()) {
        let tagsRequest = "https://api.github.com/repos/\(accountName)/\(repositoryName)/topics"
        
        if let url = URL(string: tagsRequest) {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    completion([String]())
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    if let dictionary = json as? [String: Any] {
                        if let arrayOfTags = dictionary["names"] as? [String] {
                            completion(arrayOfTags)
                        }
                    }
                } catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
    }
    
}
