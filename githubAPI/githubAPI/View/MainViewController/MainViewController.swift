//
//  MainVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    // MARK: - ViewModel
    
    var viewModel: ViewModelProtocol!
    
    // MARK: - Source data
    
    var accountName = "CocoaPods"
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - View Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(accountName: self.accountName) { [weak self] repositories in
            DispatchQueue.main.async {
                self?.navigationItem.title = "\(repositories.count) Repositories (\(self?.accountName ?? ""))"
                self?.tableView.reloadData()
                self?.spinner.stopAnimating()
            }
        }
    }
    
    // MARK: - Deinit
    
    deinit { print("\n  MainViewController deallocated") }
    
    // MARK: - Actions
    
    @IBAction func refreshRepositories(_ sender: UIBarButtonItem) {
        self.spinner.startAnimating()
        
        viewModel.fetchRepositories(from: accountName)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Repository Cell":
                if let vc = segue.destination as? DetailTableViewController {
                    if let cell = sender as? RepositoryTableViewCell {
                        let repositories = viewModel.getRepositories()
                        
                        if let indexInArray = repositories.index(where: { (repository) -> Bool in
                            repository.name == cell.repositoryName.text ?? ""
                        }) {
                            vc.repository = repositories[indexInArray]
                        }
                    }
                }
            default: break
            }
        }
    }

}
