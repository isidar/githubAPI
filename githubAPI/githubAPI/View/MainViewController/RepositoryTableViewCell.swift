//
//  RepositoryTableViewCell.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private(set)var repositoryName: UILabel!
    @IBOutlet weak private(set)var repositoryDescription: UILabel!
    @IBOutlet weak private(set)var forkCount: UILabel!
    @IBOutlet weak private(set)var starsCount: UILabel!
    
}
