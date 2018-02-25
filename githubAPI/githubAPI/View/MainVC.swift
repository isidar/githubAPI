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
    var accountName = "CocoaPods"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(accountName: self.accountName) { repositories in
            DispatchQueue.main.sync {
                self.navigationItem.title = "\(repositories.count) Repositories (\(self.accountName))"
                self.tableView.reloadData()
                
                self.spinner.stopAnimating()
            }
        }
    }
    
    @IBAction func refreshRepositories(_ sender: UIBarButtonItem) {
        self.spinner.startAnimating()
        
        viewModel.fetchRepositories(from: accountName)
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
            repositoryCell.repositoryDescription.text = repository.descriptionInfo
            repositoryCell.forkCount.text = repository.forks
            repositoryCell.starsCount.text = repository.stars
        }
        
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Repository Cell":
                if let vc = segue.destination as? DetailTableVC {
                    if let cell = sender as? RepositoryTableViewCell {
                        let repositories = viewModel.getRepositories()
                        let indexInArray = repositories.index(where: { (repository) -> Bool in
                            repository.name == cell.repositoryName.text!
                        })
                        
                        vc.repository = repositories[indexInArray!]
                    }
                }
            default: break
            }
        }
    }

}
