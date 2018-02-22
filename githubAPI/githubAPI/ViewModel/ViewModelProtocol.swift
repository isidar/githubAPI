//
//  ViewModelProtocol.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    func fetchRepositories(from accountName: String)
    func getRepositories() -> [Repository]
    
    init(accountName: String, updatedRepositories: @escaping ([Repository]) -> ())
}
