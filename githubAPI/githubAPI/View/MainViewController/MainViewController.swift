//
//  MainVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - ViewModel
    
    private let viewModel: ViewModelProtocol = ViewModel()
    
    // MARK: - Source data
    
    private let accountName = "CocoaPods"
    private var repositories: [Repository] = []
    
    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    private var repositoriesFetchingCompletion: RepositoriesFetchingCompletion?
    // MARK: - View Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoriesFetchingCompletion = { [weak self] in
            guard let welf = self else { return }
            
            switch $0 {
            case .success(let repositories):
                DispatchQueue.main.async {
                    welf.navigationItem.title = "\(repositories.count) Repositories in \(welf.accountName) account"
                    welf.repositories = repositories.sorted { ($0.name ?? "").lowercased() < ($1.name ?? "").lowercased() }
                    welf.tableView.reloadData()
                    welf.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        startFetching()
    }
    
    // MARK: - Actions
    
    @IBAction private func refreshRepositories(_ sender: UIBarButtonItem) {
        startFetching()
    }
    
    private func startFetching() {
        spinner.startAnimating()
        viewModel.fetchRepositories(fromAccount: accountName, completion: repositoriesFetchingCompletion)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "Repository Cell":
            guard let vc = segue.destination as? DetailTableViewController,
                  let cell = sender as? RepositoryTableViewCell else { break }
            
            vc.repository = repositories.first { $0.name == (cell.repositoryName.text ?? "") }
        default: break
        }
    }

}

// MARK: - TableView Data Source
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 101
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        
        guard let repository = repositories[safe: indexPath.row],
              let repositoryCell = cell as? RepositoryTableViewCell else { return cell }
        
        repositoryCell.repositoryName.text = repository.name
        repositoryCell.repositoryDescription.text = repository.descriptionInfo
        repositoryCell.forkCount.text = repository.forks.string(ifNil: "-")
        repositoryCell.starsCount.text = repository.stars.string(ifNil: "-")
        
        return repositoryCell
    }
    
}
