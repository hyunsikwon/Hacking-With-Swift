//
//  TableViewController.swift
//  MilestoneChallenge2
//
//  Created by 원현식 on 2020/02/25.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [shareBarButton, addBarButton]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
        
    }
    
    //MARK: - IBActions
    @IBAction func deleteAll(_ sender: Any) {
        
        shoppingList.removeAll()
        tableView.reloadData()
        
    }
    
    
    
    // MARK: - Private Methods
    @objc private func addTapped() {
        let ac = UIAlertController(title: nil , message: "구매할 물품 추가", preferredStyle: .alert)
        ac.addTextField()
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let shoppingItem = ac?.textFields?[0].text else { return }
            if !shoppingItem.isEmpty {
                self?.addItem(shoppingItem)
            }
            
        }
        
        
        ac.addAction(action)
        ac.addAction(cancel)
        
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
    private func addItem(_ item: String) {
        let indexPath = IndexPath(row: shoppingList.count, section: 0)
        shoppingList.append(item)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    
}
