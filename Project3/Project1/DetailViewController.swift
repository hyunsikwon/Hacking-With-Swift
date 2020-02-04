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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let selectedImage = selectedImage else {
            print("No image found")
            return
        }
        
        // activityItems is an array of items you want to share. applicationActivities is an array of our own app services.
        let vc = UIActivityViewController(activityItems: [image, selectedImage], applicationActivities: [])
        
        // Location where the viewController needs to be anchored. Optional because this code only runs on iPads. iPhones display activity view controllers using full screen.
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
// We start with the method name, marked with @objc because this method will get called by the underlying Objective-C operating system (the UIBarButtonItem) so we need to mark it as being available to Objective-C code. When you call a method using #selector you’ll always need to use @objc too.
    
    
}

