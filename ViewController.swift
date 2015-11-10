//
//  ViewController.swift
//  Countio
//
//  Created by Edouard Barbier on 14/08/15.
//  Copyright (c) 2015 Edouard Barbier. All rights reserved.
//

import UIKit

let countioBrain = CountioBrain()

var highestScore = 0
var endScore = 0 //Score when users fails

class ViewController: UIViewController, UITextFieldDelegate {
    
    var valueToGuess: Int = 0
    var score = 0 {
        didSet {
            currentScoreLabel.text = "\(score)"
        }
    }
    
    var statusAnswer = false
    
    var intGuessed = 0 {
        didSet {
            checkGuess(intGuessed)
            print(statusAnswer)
        }
    }
    
    var operationsArrray = ["+","-"]
    
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var currentResultLabel: UILabel!
    @IBOutlet weak var nextValueLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var guessedResultLabel: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    

    var counter = 5.0 {
        
        didSet{
            
            //countdownLabel.text = String(format: "%.1f", counter)
            
            let fractionalProgress = Float(counter)*20 / 100.0
            
            progressBar.setProgress(fractionalProgress, animated: false)
        checkRemainingTime(counter)
        }
    }
    
    
    
    
    var timer = NSTimer()

    
    
    @IBAction func submit(sender: AnyObject) {
        
        if guessedResultLabel.text != "" {
  
            intGuessed = Int((guessedResultLabel.text)!)!
            print("Value guessed: \(guessedResultLabel.text)")
            print("Value to guess: \(valueToGuess)")
            
            //GOOD ANSWER
            if intGuessed == valueToGuess {
                counter = 5.0
                feedbackLabel.text = "Well done! +1"
                score += 1
                endScore = score
                currentResultLabel.text = "\(intGuessed)"

                if intGuessed < 5 {
                    
                    operationLabel.text = "\(operationsArrray[0])"
                } else {
                    
                    operationLabel.text = "\(operationsArrray[countioBrain.randNextValue(0, upper: 1)])"
                }
            
                nextValueLabel.text = "\(countioBrain.generateRandomNumber(Int(currentResultLabel.text!)!, currentOperation: operationLabel.text!))"
                guessedResultLabel.text = ""
            
            //WRONG ANSWER
            } else {
                feedbackLabel.text = "Wrong"
                score = 0
                endScore = 0
                guessedResultLabel.text = ""
                currentResultLabel.text = "\(countioBrain.randNextValue(1, upper: 5))"
                operationLabel.text = "\(operationsArrray[countioBrain.randNextValue(0, upper: 1)])"
                nextValueLabel.text = "\(countioBrain.generateRandomNumber(Int(currentResultLabel.text!)!, currentOperation: operationLabel.text!))"

            }
        
            if score > Int(highestScoreLabel.text!)! {
                highestScoreLabel.text = currentScoreLabel.text
            }
        } else {
            feedbackLabel.text = "Please enter a number"
            }
        
        if operationLabel.text == "+" {
            valueToGuess = Int(currentResultLabel.text!)! + Int(nextValueLabel.text!)!
        } else {
            valueToGuess = Int(currentResultLabel.text!)! - Int(nextValueLabel.text!)!
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        progressBar.setProgress(1, animated: false)

        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("countdown"), userInfo: nil, repeats: true) //countdown

        self.navigationController?.navigationBarHidden = true
        
        currentResultLabel.text = "\(countioBrain.randNextValue(1, upper: 5))"
        
        operationLabel.text = "\(operationsArrray[countioBrain.randNextValue(0, upper: 1)])"

        nextValueLabel.text = "\(countioBrain.generateRandomNumber(Int(currentResultLabel.text!)!, currentOperation: operationLabel.text!))"
        
        currentScoreLabel.text = "\(score)"
        guessedResultLabel.delegate = self
        guessedResultLabel.becomeFirstResponder()
        guessedResultLabel.text = ""
        
        if operationLabel.text == "+" {
              valueToGuess = Int(currentResultLabel.text!)! + Int(nextValueLabel.text!)!
        } else {
            valueToGuess = Int(currentResultLabel.text!)! - Int(nextValueLabel.text!)!
        }
        
        print(currentResultLabel)
    }
    
    
    func countdown() {
        
        if counter > 0.01 {
            
            counter = counter - 0.01
        } else {
            
            counter = 0.0
            
        }
    }

   
    
    override func viewWillAppear(animated: Bool) {
        
        guessedResultLabel.delegate = self
        guessedResultLabel.becomeFirstResponder()
        guessedResultLabel.text = ""
        feedbackLabel.text = "Let's play!"
        counter = 5.0
        
    }
    
    
    func checkGuess(guessedResultLabel: Int) -> Bool {
        
        if guessedResultLabel == valueToGuess {
            statusAnswer = true
            return statusAnswer
        } else {
            
            score = 0
            self.performSegueWithIdentifier("gameOver", sender: self)
            statusAnswer = false
            return statusAnswer
        }
  
    }
    
    
    func checkRemainingTime(time: Double) {
        
        if time == 0.0 {
            
            self.performSegueWithIdentifier("gameover", sender: nil)
        }
    }
    
    
    
}

