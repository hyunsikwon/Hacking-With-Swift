//
//  TableViewController.swift
//  Project7
//
//  Created by 원현식 on 2020/02/25.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
            
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        let filterBarButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        let showAllBarButton = UIBarButtonItem(title: "Show All", style: .plain, target: self, action: #selector(showAll))
        
        navigationItem.leftBarButtonItems = [filterBarButton,showAllBarButton]
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            
            self.showError()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPetitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = filteredPetitions[indexPath.row].title
        cell.detailTextLabel?.text = filteredPetitions[indexPath.row].body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Private Methods
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    private func showFilteredList(_ answer: String) {
        filteredPetitions = []
        
        for petition in petitions {
            if petition.title.contains(answer) {
                filteredPetitions.append(petition)
            }
        }
        
        tableView.reloadData()
    }
    
    //MARK: - @Objc
    @objc private func showCredit() {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        ac.addAction(action)
        present(ac,animated: true)
        
    }
    
    @objc private func filterTapped() {
        let ac = UIAlertController(title: nil, message: "검색", preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "search", style: .default, handler: { [weak self, weak ac]_ in
            guard let answer = ac?.textFields?[0].text else { return }
            if !answer.isEmpty{
                self?.showFilteredList(answer)
            }
            
        })
        
        ac.addAction(action)
        
        present(ac,animated: true)
    }
    
    @objc private func showAll() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    

}
