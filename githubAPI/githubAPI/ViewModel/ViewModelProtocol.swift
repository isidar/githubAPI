//
//  ViewModelProtocol.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    /// Fetches repositories from particular account and executes given function
    func fetchRepositories(from accountName: String, updateUI: Updater?)
    /// Fetches repositories from particular account and executes early given function
    func fetchRepositories(from accountName: String)
    /// Returns array of repositories in alphabetical order
    func getRepositories() -> [Repository]
    
    init(accountName: String, updateUI: Updater?)
}

typealias Updater = ([Repository]) -> ()
