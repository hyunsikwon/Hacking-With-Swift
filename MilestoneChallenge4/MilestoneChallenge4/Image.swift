//
//  Photo.swift
//  MilestoneChallenge4
//
//  Created by 원현식 on 2020/03/11.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import Foundation

class Image: NSObject, Codable {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
    
}
