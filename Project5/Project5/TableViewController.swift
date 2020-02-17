//
//  TableViewController.swift
//  Project5
//
//  Created by 원현식 on 2020/02/12.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "restart", style: .plain, target: self, action: #selector(startGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    
    //MARK: - Priavate Methods
    
    @objc private func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll()
        //        calling reloadData() forces it to call numberOfRowsInSection again, as well as calling cellForRowAt repeatedly.
        tableView.reloadData()
    }
    
    @objc private func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        // handler parameter 사용대신 클로저 사용. action in means that it accepts one parameter in, of type UIAlertAction. action -> _
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) { // the word is possible, the word hasn't been used yet, and the word is a real word
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0) // add it to the start of the array,
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    // so using insertRows() lets us tell the table view that a new row has been placed at a specific place in the array so that it can animate the new cell appearing.
                    return
                    
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                    
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }
        
        showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
    }
    
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for char in word {
            if let position = tempWord.firstIndex(of: char) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isOriginal(word: String) -> Bool {
        let lowerWord = word.lowercased()
        let upperWord = word.uppercased()
        
        return !usedWords.contains(lowerWord) && !usedWords.contains(upperWord)
    }
    
    private func isReal(word: String) -> Bool {
        
        if word.count < 3 {
            return false
        }
        let checker = UITextChecker()
        // This is an iOS class that is designed to spot spelling errors, which makes it perfect for knowing if a given word is real or not.
        
        let range = NSRange(location: 0, length: word.utf16.count)
        // This is used to store a string range, which is a value that holds a start position and a length. We want to examine the whole string, so we use 0 for the start position and the string's length for the length.
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location == NSNotFound {
            return true
        } else {
            return false
        }
        
    }
    
    private func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    
}
