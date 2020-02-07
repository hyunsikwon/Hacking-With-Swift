//
//  TableViewController.swift
//  MilestoneChallenge1
//
//  Created by 원현식 on 2020/02/07.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        title = "Flags"
        
        loadFlags()
    }
    
    private func loadFlags() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
        
    }
    
    private func rename(text: String) -> String {
        let country = text.replacingOccurrences(of: ".png", with: "")
        
        let countryName = country.count <= 2  ? country.uppercased() : country.capitalized
        
        return countryName
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
  
        let countryName = rename(text: flags[indexPath.row])
        
        cell.textLabel?.text = countryName
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        cell.imageView?.layer.borderWidth = 0.3
        cell.imageView?.layer.borderColor = UIColor.gray.cgColor
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController {
            vc.flag = UIImage(named: flags[indexPath.row])
            vc.countryName = rename(text: flags[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
