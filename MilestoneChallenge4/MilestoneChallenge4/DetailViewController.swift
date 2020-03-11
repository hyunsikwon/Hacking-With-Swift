//
//  DetailViewController.swift
//  MilestoneChallenge4
//
//  Created by 원현식 on 2020/03/11.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var caption: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let caption = caption {
            title = caption
        }
        if let image = image {
            imageView.image = image
            
        }
        
    }
    
    
}
