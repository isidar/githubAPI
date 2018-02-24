//
//  ViewModel.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

class ViewModel: ViewModelProtocol {
    // Model
    private var repositories = [Repository]() {
        didSet {
            updateUI?(self.repositories)
        }
    }
    
    private var updateUI: Updater?
    
    required init(accountName: String, updateUI: Updater?) {
        fetchRepositories(from: accountName, updateUI: updateUI)
    }
    
    func fetchRepositories(from accountName: String, updateUI: Updater?) {
        self.updateUI = updateUI
        
        _ = GithubAPIManager(accountName: accountName) { repositories, errorMessage in
            self.repositories = repositories
        }
    }
    
    func fetchRepositories(from accountName: String) {
        _ = GithubAPIManager(accountName: accountName) { repositories, errorMessage in
            self.repositories = repositories
        }
    }
    
    func getRepositories() -> [Repository] {
        return repositories.sorted(by: {
            $0.name.lowercased() < $1.name.lowercased()
        })
    }
    
}
