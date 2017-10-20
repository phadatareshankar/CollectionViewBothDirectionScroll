//
//  PhotoCollectionViewController.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/19/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
     let categories = PhotoCategory.fetchPhotos()
    
    
    struct Storyboard {
        static let photoCell = "PhotosCellCollection"
        static let photoCollectionCell = "PhotosCollectionCell"
        
        static let showDetailSegue = "ShowDetail"
        static let showPhotoDetailSegue = "showPhotoDetails"
        
        static let leftAndRightPaddings: CGFloat = 1.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PhotoCollectionViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCollectionCell
        
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
        cell.collectionView.tag = indexPath.section
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].categoryName
    }
    
    
    //#MARK: CollectionViewData and Delegates
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / Storyboard.numberOfItemsPerRow) - Storyboard.leftAndRightPaddings), height: CGFloat((collectionView.frame.size.width / Storyboard.numberOfItemsPerRow) - Storyboard.leftAndRightPaddings))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[collectionView.tag].imageNames.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCollectionCell, for: indexPath) as! PhotosCollectionCell
        
        cell.photoImageView.image = UIImage(named: categories[collectionView.tag].imageNames[indexPath.row])
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: categories[collectionView.tag].imageNames[indexPath.row])
        self.performSegue(withIdentifier: Storyboard.showPhotoDetailSegue, sender: image)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.showPhotoDetailSegue {
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = sender as? UIImage
        }
        
    }
    
}
