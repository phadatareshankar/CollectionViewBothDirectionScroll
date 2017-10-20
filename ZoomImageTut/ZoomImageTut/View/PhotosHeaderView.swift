//
//  PhotosHeaderView.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/18/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit

class PhotosHeaderView: UICollectionReusableView {
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var headerNameLbl: UILabel!
    
    var category: PhotoCategory! {
        didSet {
            photoImageView.image = UIImage(named: category.categoryName)
            headerNameLbl.text = category.categoryName
        }
    }
    
}
