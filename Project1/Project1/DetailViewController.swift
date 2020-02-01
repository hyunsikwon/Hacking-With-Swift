//
//  DetailViewController.swift
//  Project1
//
//  Created by 원현식 on 2020/02/01.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var selectedPictureNumber: Int?
    var totalPicture: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage, let selectedPictureNumber = selectedPictureNumber, let totalPictures = totalPicture {
            title = "Picture \(selectedPictureNumber) of \(totalPictures)"
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
}

