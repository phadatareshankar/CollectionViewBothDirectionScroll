//
//  DetailViewController.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/19/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,ZoomingProtocol {
    
    
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
       return photoImageView
    }

    var image: UIImage!
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true
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
