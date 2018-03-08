//
//  SupportCell.swift
//  MovieApp
//
//  Created by Apit on 3/8/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit

class SupportCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var detailMovie: [Artist] = [Artist]()
    var artistId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let cellSize = CGSize(width:144 , height:265)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib.init(nibName: "AktrisCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AktrisCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AktrisCollectionCell", for: indexPath) as! AktrisCollectionViewCell
        if detailMovie.count > 0 {
            let artist = detailMovie[indexPath.row]
            let url = WebService.baseImageApi + artist.profileImage
            cell.profileImage.sd_setImage(with: URL(string: url))
            cell.originalNameLabel.text = artist.fullName
            cell.castNameLabel.text = artist.character
        }
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
