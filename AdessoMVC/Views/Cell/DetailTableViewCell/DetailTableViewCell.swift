//
//  DetailTableViewCell.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailTableViewCellProtocol: class {
    func addedToReadingList(details: DetailsModel)
}
class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readListButton: UIButton!

    weak var delegate: DetailTableViewCellProtocol?
    var details: DetailsModel!
    var result : DetailsModel!
    var publishedAt = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
           super.prepareForReuse()
           readListButton.setTitle("", for: .normal)
       }
       
       func configure(details: DetailsModel) {
           self.details = details
           let title = details.title
           let time = details.publishedDate
           let imageUrl = details.urlToImage
           let isAddedToReadingList = details.isAddedToReadingList
           let buttonTitle: String = isAddedToReadingList ? "Okuma Listemden Çıkart" : "Okuma Listeme Ekle"

           publishedAt = time
           titleLabel.text = title
           detailImageView.kf.setImage(with: URL(string: imageUrl ?? ""))
           timeLabel.text = time
           readListButton.setTitle(buttonTitle, for: .normal)

       }

    @IBAction func readListButtonClicked(_ sender: Any) {
        details.isAddedToReadingList.toggle()
        let isAddedToReadingList = details.isAddedToReadingList
        let buttonTitle: String = isAddedToReadingList ? "Okuma Listemden Çıkart" : "Okuma Listeme Ekle"
        readListButton.setTitle(buttonTitle, for: .normal)
        delegate?.addedToReadingList(details: details)
    }
    
}
