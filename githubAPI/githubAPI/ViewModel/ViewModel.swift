//
//  ViewModel.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    /// Fetches repositories from certain account and executes early given function
    func fetchRepositories(fromAccount account: String, completion: RepositoriesFetchingCompletion?)
}

enum FetchingError: Error {
    case plain(Error)
    case other(String)
}

typealias RepositoriesFetchingCompletion = (Result<[Repository], FetchingError>) -> Void

class ViewModel: ViewModelProtocol {
    
    /// Fetches repositories from certain account
    func fetchRepositories(fromAccount account: String, completion: RepositoriesFetchingCompletion?) {
        GithubAPIManager.fetchRepositories(fromAccount: account, completion: completion)
    }
    
}
