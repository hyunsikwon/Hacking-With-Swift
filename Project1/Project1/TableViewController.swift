//
//  TableViewController.swift
//  Project1
//
//  Created by 원현식 on 2020/02/01.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! ///Users/hyunsikwon/Library/Developer/CoreSimulator/Devices/A918701B-6D05-4056-8306-F393D2376FB7/data/Containers/Bundle/Application/7B226FE4-4FA4-499F-8F22-1DDF6415A790/Project1.app
        
        DispatchQueue.global().async {
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl") {
                    self.pictures.append(item)

                }
            }
            self.pictures.sort()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1;
            vc.totalPicture = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: Private Methods
    @objc private func shareTapped() {
        let shareMessage = "Download Project 1 to get awesome pictures of great storms"
        let vc = UIActivityViewController(activityItems: [shareMessage], applicationActivities: [])
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
}
