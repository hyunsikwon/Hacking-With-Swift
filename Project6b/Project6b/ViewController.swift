//
//  ViewController.swift
//  Project6b
//
//  Created by 원현식 on 2020/02/19.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints  = false
        // default iOS generates Auto Layout constraints for you based on a view's size and position. We'll be doing it by hand, so we need to disable this feature.
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
            // adds an array of constraints to our view controller's view.
            //  Auto Layout method that converts VFL into an array of constraints.

            /*
             The H: parts means that we're defining a horizontal layout; we'll do a vertical layout soon.
             The pipe symbol, |, means "the edge of the view." We're adding these constraints to the main view inside our view controller, so this effectively means "the edge of the view controller."
             Finally, we have [label1], which is a visual way of saying "put label1 here". Imagine the brackets, [ and ], are the edges of the view.
             */
//        }

//        let metrics = ["labelHeight": 88]
//        view.addConstraints( NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=5)-|",
//            options: [],
//            metrics: metrics,
//            views: viewsDictionary))
        
        var previous: UILabel?
        for label in [label1,label2,label3,label4,label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18, constant: -10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
   
    }
    
    
}

