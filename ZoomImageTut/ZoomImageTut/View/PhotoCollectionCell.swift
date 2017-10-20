//
//  PhotoCollectionCell.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/19/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit

class PhotoCollectionCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
