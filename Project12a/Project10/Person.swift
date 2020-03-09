//
//  Person.swift
//  Project10
//
//  Created by 원현식 on 2020/03/04.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder: NSCoder) { // The initializer is used when loading objects of this class.
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) { // encode() is used when saving. 
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }

}
