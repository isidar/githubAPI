//
//  RepositoryTableViewCell.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet private(set)var repositoryName: UILabel!
    @IBOutlet private(set)var repositoryDescription: UILabel!
    @IBOutlet private(set)var forkCount: UILabel!
    @IBOutlet private(set)var starsCount: UILabel!
    
}
