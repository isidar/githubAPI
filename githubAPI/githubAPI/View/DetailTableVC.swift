//
//  DetailTableVC.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class DetailTableVC: UITableViewController {
    var repository: Repository!
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryURL: UILabel!
    @IBOutlet weak var repositoryForks: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!
    @IBOutlet weak var repositoryAuthor: UILabel!
    @IBOutlet weak var repositoryTags: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAllFields()
    }
    
    func updateAllFields() {
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
    
    @IBAction func urlClick(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: repositoryURL.text!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
