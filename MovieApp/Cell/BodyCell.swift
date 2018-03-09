//
//  BodyCell.swift
//  MovieApp
//
//  Created by Apit on 3/8/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit

class BodyCell: UITableViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
