//
//  ViewModel.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

class ViewModel: ViewModelProtocol {
    private var repositories = [Repository]() {
        didSet {
            updated(self.repositories)
        }
    }
    
    private var updated: ([Repository]) -> ()
    
    required init(accountName: String, updatedRepositories: @escaping ([Repository]) -> ()) {
        updated = updatedRepositories
        
        fetchRepositories(from: accountName)
    }
    
    func fetchRepositories(from accountName: String) {
        _ = GithubAPIManager(accountName: accountName) {repositories, errorMessage in
            self.repositories = repositories
        }
    }
    
    func getRepositories() -> [Repository] {
        return repositories
    }
    
}
