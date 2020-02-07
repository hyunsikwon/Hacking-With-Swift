//
//  DetailViewController.swift
//  MilestoneChallenge1
//
//  Created by 원현식 on 2020/02/07.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var flag: UIImage?
    var countryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = countryName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let flag = flag {
            
            imageView.image = flag
            
        }
        
    }
    
    @objc private func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let countryName = countryName else { return }
        
        let vc = UIActivityViewController(activityItems: [image,countryName], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
}
