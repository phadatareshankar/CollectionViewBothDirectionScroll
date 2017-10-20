//
//  ViewController.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/18/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, ZoomingProtocol {
    
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        
        if let indexPath = selectedIndex {
            
            let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! PhotoCell
            
            return cell.photoImageView
            
        }
        
        return nil
    }
    
    

    @IBOutlet var collectionView: UICollectionView!
    
    var selectedIndex: IndexPath?
    
    let categories = PhotoCategory.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let headerView = "PhotosHeaderView"
        static let showDetailSegue = "ShowDetail"
        
        static let leftAndRightPaddings: CGFloat = 1.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Photos"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension PhotosViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / Storyboard.numberOfItemsPerRow) - Storyboard.leftAndRightPaddings), height: CGFloat((collectionView.frame.size.width / Storyboard.numberOfItemsPerRow) - Storyboard.leftAndRightPaddings))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].imageNames.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return categories.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.headerView, for: indexPath) as! PhotosHeaderView
        
        headerview.category = categories[indexPath.section]
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        
        cell.photoImageView.image = UIImage(named: categories[indexPath.section].imageNames[indexPath.row])
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let image = UIImage(named: categories[indexPath.section].imageNames[indexPath.row])
        self.selectedIndex = indexPath
        self.performSegue(withIdentifier: Storyboard.showDetailSegue, sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.showDetailSegue {
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = sender as? UIImage
        }
        
    }
    
    
    
}

