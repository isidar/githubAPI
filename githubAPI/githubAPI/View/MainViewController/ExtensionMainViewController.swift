//
//  ExtensionMainViewController.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 3/4/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation
import  UIKit

extension MainViewController {
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRepositories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 101
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        
        // Load the cell with data
        let arrayOfRepositories = viewModel.getRepositories()
        let repository = arrayOfRepositories[indexPath.row]
        
        if let repositoryCell = cell as? RepositoryTableViewCell {
            repositoryCell.repositoryName.text = repository.name
            repositoryCell.repositoryDescription.text = repository.descriptionInfo
            repositoryCell.forkCount.text = repository.forks
            repositoryCell.starsCount.text = repository.stars
        }
        
        return cell
    }
    
    
}
