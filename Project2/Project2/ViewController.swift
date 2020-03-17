//
//  ViewController.swift
//  Project2
//
//  Created by 원현식 on 2020/02/03.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0;
    var questionNum = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        //  As you can see, UIColor has a property called lightGray that returns (shock!) a UIColor instance that represents a light gray color. But we can't put a UIColor into the borderColor property because it belongs to a CALayer, which doesn't understand what a UIColor is. So, we add .cgColor to the end of the UIColor to have it automagically converted to a CGColor. Perfect.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    //MARK: IBActions
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            sender.transform = .identity
        }, completion: nil)
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct!"
            message = "Your score is \(score)"
            alertMessage(title: title, message: message)
            
        } else {
            score -= 1
            title = "Wrong!"
            message =  "Wrong! That’s the flag of \(countries[sender.tag].uppercased())."
            alertMessage(title: title, message: message)
        }
        
    }
    
    @IBAction func showScore(_ sender: Any) {
        let ac = UIAlertController(title: "My score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Back to the Game", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
        
        
    }
    
    //MARK: Private Methods
    private func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())"
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        questionNum += 1
    }
    
    private func alertMessage(title: String, message: String) {
        var ac = UIAlertController()
        
        if questionNum < 10 {
            if title == "Correct!" {
                ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                // apple recommends you use .alert when telling users about a situation change, and .actionSheet when asking them to choose from a set of options.
                
            } else if title == "Wrong!" {
                ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            }
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            // Warning: We must use askQuestion and not askQuestion(). If you use the former, it means "here's the name of the method to run," but if you use the latter it means "run the askQuestion() method now, and it will tell you the name of the method to run."
            
        } else { // 마지막 라운드 후 alert
            ac = UIAlertController(title: title, message: "Your Final Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: askQuestion))
            score = 0
            questionNum = 0
        }
        
        present(ac,animated: true)
        //The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation.
        
    }

}

