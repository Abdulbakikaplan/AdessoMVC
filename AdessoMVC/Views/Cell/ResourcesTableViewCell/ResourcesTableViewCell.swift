//
//  ResourcesTableViewCell.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(source: SourcesModel) {

        let title = source.name
        let subTitle = source.description

        titleLabel.text = title
        descriptionLabel.text = subTitle
    }
    
}
