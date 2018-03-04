//
//  DetailTableVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    // MARK: - Model
    
    var repository: Repository?
    
    // MARK: - Outlets
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryURL: UILabel!
    @IBOutlet weak var repositoryForks: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!
    @IBOutlet weak var repositoryAuthor: UILabel!
    @IBOutlet weak var repositoryTags: UILabel!
    
    // MARK: - View Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAllFields()
    }
    
    // MARK: - Deinit
    
    deinit { print("\n  DetailTableViewController deallocated") }
    
    // MARK: - Actions
    
    @IBAction func urlClick(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: repositoryURL.text!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Other functions
    
    /// Fills all outlets with appropriate repository data
    func updateAllFields() {
        if let repository = repository {
            repositoryName.text = repository.name
            repositoryDescription.text = repository.descriptionInfo
            repositoryURL.text = repository.URL
            repositoryForks.text = repository.forks
            repositoryStars.text = repository.stars
            repositoryAuthor.text = repository.author
            repositoryTags.text = repository.tags.isEmpty ?
                "no tags" :
                repository.tags.printElements()
        }
    }
    
}
