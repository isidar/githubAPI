//
//  MainVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource {
    var viewModel: ViewModelProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(accountName: "CocoaPods") {[weak self] repositories in
            DispatchQueue.main.sync {
                self?.navigationItem.title = "\(repositories.count) Repositories (CocoaPods)"
                self?.tableView.reloadData()
            }
        }
    }
    
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
            repositoryCell.repositoryDescription.text = repository.description
            repositoryCell.forkCount.text = repository.forks
            repositoryCell.starsCount.text = repository.stars
        }
        
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Repository":
                if let vc = segue.destination as? DetailTableVC {
                    vc.viewModel = viewModel
                }
            default: break
            }
        }
    }
 

}