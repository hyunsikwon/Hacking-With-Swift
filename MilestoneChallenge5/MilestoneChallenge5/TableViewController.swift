//
//  TableViewController.swift
//  MilestoneChallenge5
//
//  Created by 원현식 on 2020/03/17.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            if let jsonString = try? String(contentsOfFile: path) {
                print(jsonString)
                if let data = jsonString.data(using: .utf8) {
                    parse(json: data)
                    
                } else {
                    print("data error")
                }
            }else {
                print("string error")
            }
        } else {
            print("error")
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)

        cell.textLabel?.text = countries[indexPath.row].name

        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let destination = segue.destination as? DetailTableViewController, let indexPath = tableView.indexPathForSelectedRow {
                destination.country = countries[indexPath.row]
            }
            
        }
    }
    
    private func parse(json: Data) {
        let jsonDecoder = JSONDecoder()
        if let jsonCountries = try? jsonDecoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
            tableView.reloadData()
        }
    }
    

}
