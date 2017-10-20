//
//  PhotosModel.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/18/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit



struct PhotoCategory {
    
    var categoryName: String
    var imageNames:[String]
    
    static func fetchPhotos() -> [PhotoCategory]{
        
        var categories = [PhotoCategory]()
        let photosData = PhotosModel.downloadPhotoData()
        
        for photos in photosData {
            if let dict = photos as? [String:Any]{
                let newCategory = PhotoCategory(categoryName: dict["CategoryName"] as! String, imageNames: dict["images"] as! [String])
                categories.append(newCategory);
            }
        }
        
        return categories
    }
    
}

class PhotosModel: NSObject {
    
    class func downloadPhotoData() -> [Any]{
        
        return [
            ["CategoryName": "family",
                "images": PhotosModel.photoImages(categoryName: "f", numberOfImages: 9)],
            ["CategoryName": "foods",
            "images": PhotosModel.photoImages(categoryName: "fo", numberOfImages: 8)],
            ["CategoryName": "nature",
            "images": PhotosModel.photoImages(categoryName: "n", numberOfImages: 8)],
            ["CategoryName": "travel",
            "images": PhotosModel.photoImages(categoryName: "t", numberOfImages: 9)]
        ]
        
    }
    
    class func photoImages(categoryName:String, numberOfImages:Int) -> [String] {
        
        var images = [String]()
        
        for i in 1...numberOfImages {
            images.append("\(categoryName)\(i)");
        }
        
        return images
        
    }
    

}
