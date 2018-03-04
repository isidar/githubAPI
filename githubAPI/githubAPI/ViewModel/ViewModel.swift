//
//  ViewModel.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

class ViewModel: ViewModelProtocol {
    // MARK: - Model
    
    private var repositories = [Repository]() {
        didSet {
            updateUI?(self.repositories)
        }
    }
    
    // MARK: - Data source
    
    private var updateUI: Updater?
    
    // MARK: - Inits
    
    required init(accountName: String, updateUI: Updater?) {
        fetchRepositories(from: accountName, updateUI: updateUI)
    }
    
    // MARK: - Deinit
    
    deinit { print("\n  ViewModel deallocated") }
    
    // MARK: - Other functions
    
    /// Fetches repositories from certain account and executes given function
    func fetchRepositories(from accountName: String, updateUI: Updater?) {
        self.updateUI = updateUI
        
        _ = GithubAPIManager(accountName: accountName) { repositories, errorMessage in
            self.repositories = repositories
        }
    }
    
    /// Fetches repositories from certain account and executes early given function
    func fetchRepositories(from accountName: String) {
        _ = GithubAPIManager(accountName: accountName) { repositories, errorMessage in
            self.repositories = repositories
        }
    }
    
    /// Returns array of repositories in alphabetical order
    func getRepositories() -> [Repository] {
        return repositories.sorted(by: {
            $0.name.lowercased() < $1.name.lowercased()
        })
    }
    
    
}
