//
//  Country.swift
//  MilestoneChallenge5
//
//  Created by 원현식 on 2020/03/17.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var gdp: Int
    var population: Int
    var currency: String
}

struct Countries: Codable {
    var results: [Country]
}
