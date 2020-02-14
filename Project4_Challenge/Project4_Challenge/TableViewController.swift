//
//  TableViewController.swift
//  Project4_Challenge
//
//  Created by 원현식 on 2020/02/14.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let websites = ["apple.com", "hackingwithswift.com", "microsoft.com" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Websites"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "URLCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "WebView") as? ViewController {
            vc.website = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }

   

}
