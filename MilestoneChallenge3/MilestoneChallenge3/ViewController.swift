//
//  ViewController.swift
//  MilestoneChallenge3
//
//  Created by 원현식 on 2020/03/02.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var incorrectLabel: UILabel!
    
    
    var incorrectCount = 0 {
        didSet {
            incorrectLabel.text = "incorrect: \(incorrectCount)"
        }
    }
    
    var gameData = ["horse", "mountain", "sofa", "window", "television"]
    var correctAnswer = ""
    var usedLetters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
    }
    
    private func loadGame(_ action: UIAlertAction! = nil) {
        usedLetters = []
        // TODO: 버튼 초기화
        
        gameData.shuffle()
        correctAnswer = gameData[0]
        answerLabel.text = ""
        for _ in 0 ..< correctAnswer.count {
            answerLabel.text! += "?"
        }
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        var tempAnswer = ""
        if correctAnswer.contains(buttonTitle) {
            usedLetters.append(buttonTitle)
            
            for letter in correctAnswer {
                let strLetter = String(letter)
                
                if usedLetters.contains(strLetter) {
                    tempAnswer += strLetter
                } else {
                    tempAnswer += "?"
                }
            }
            
            answerLabel.text = tempAnswer
            if answerLabel.text == correctAnswer {
                print("성공")
                let ac = UIAlertController(title: "게임 성공", message: "정답은 \(correctAnswer)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "새로운 게임", style: .default, handler: loadGame))
                present(ac,animated: true)
            }
            
            sender.titleLabel?.text = ""
            sender.isEnabled = false
            
        } else {
            
            incorrectCount += 1
            
            if incorrectCount == 7 {
    
                let ac = UIAlertController(title: "실패", message: "정답은 \(correctAnswer)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "새로운 게임", style: .default, handler: loadGame))
                present(ac,animated: true)
                
            }
            
            sender.titleLabel?.text = ""
            sender.isEnabled = false
        }
        
    }
    
}

