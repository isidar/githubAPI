//
//  DetailTableVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var repository: Repository?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var repositoryName: UILabel!
    @IBOutlet private weak var repositoryDescription: UILabel!
    @IBOutlet private weak var repositoryURL: UILabel!
    @IBOutlet private weak var repositoryForks: UILabel!
    @IBOutlet private weak var repositoryStars: UILabel!
    @IBOutlet private weak var repositoryAuthor: UILabel!
    @IBOutlet private weak var repositoryTags: UILabel!
    
    // MARK: - View Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAllFields()
    }
    
    // MARK: - Actions
    
    @IBAction private func urlClick(_ sender: UITapGestureRecognizer) {
        guard let urlString = repositoryURL.text,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Other functions
    
    private func updateAllFields() {
        guard let repository = repository else { return }
        
        repositoryName.text = repository.name
        repositoryDescription.text = repository.descriptionInfo
        repositoryURL.text = repository.URL
        repositoryForks.text = repository.forks.string(ifNil: "-")
        repositoryStars.text = repository.stars.string(ifNil: "-")
        repositoryAuthor.text = repository.author
        if let tags = repository.tags {
            repositoryTags.text = tags.isEmpty ?
                                  "no tags" :
                                  tags.join()
        } else {
            repositoryTags.text = "-"
        }
    }
    
}
