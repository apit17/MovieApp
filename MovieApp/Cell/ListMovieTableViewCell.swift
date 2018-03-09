//
//  ListMovieTableViewCell.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit

class ListMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var dateMovieLabel: UILabel!
    @IBOutlet weak var contentMovieLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
