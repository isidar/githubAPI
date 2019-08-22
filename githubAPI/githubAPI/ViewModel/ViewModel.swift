//
//  ViewModel.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    /// Fetches repositories from certain account and executes given function
    func fetchRepositories(fromAccount account: String, updateUI: Updater?)
    /// Fetches repositories from certain account and executes early given function
    func fetchRepositories(fromAccount account: String)
    
    var repositories: [Repository] { get }
    
    init(accountName: String, updateUI: Updater?)
}

typealias Updater = ([Repository]) -> Void

class ViewModel: ViewModelProtocol {
    
    private(set) var repositories: [Repository] = [] {
        didSet {
            updateUI?(repositories)
        }
    }
    
    private var updateUI: Updater?
    
    // MARK: - Inits
    
    required init(accountName: String, updateUI: Updater?) {
        fetchRepositories(fromAccount: accountName, updateUI: updateUI)
    }
    
    // MARK: - Other functions
    
    /// Fetches repositories from certain account and executes given function
    func fetchRepositories(fromAccount account: String, updateUI: Updater?) {
        self.updateUI = updateUI
        fetchRepositories(fromAccount: account)
    }
    
    /// Fetches repositories from certain account and executes early given function
    func fetchRepositories(fromAccount account: String) {
        GithubAPIManager.fetchRepositories(fromAccount: account) { result in
            switch result {
            case .success(let repositories):
                self.repositories = repositories
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
