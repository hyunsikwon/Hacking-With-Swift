//
//  DetailTableViewController.swift
//  MilestoneChallenge5
//
//  Created by 원현식 on 2020/03/17.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet var capitalCityLabel: UILabel!
    @IBOutlet var gdpLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!

    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let country = country {
            title = country.name
            capitalCityLabel.text = country.capital
            gdpLabel.text = "\(String(country.gdp))$"
            populationLabel.text = "\(String(country.population)) 명"
            currencyLabel.text = country.currency
        }
        
    }



}
