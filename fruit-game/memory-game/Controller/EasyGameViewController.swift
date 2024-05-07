//
//  EasyGameViewController.swift
//  memory-game
//
//  Created by  on 4/30/24.
//

import UIKit
import Foundation

class EasyGameViewController: UIViewController {
    
    //views
    @IBOutlet weak var button1: UIImageView!
    @IBOutlet weak var button2: UIImageView!
    @IBOutlet weak var button3: UIImageView!
    @IBOutlet weak var button4: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //variables
    var boardCount = 0
    var standingGuessImage = "None"
    var previousGuess = 0
    var firstGuess = 0
    static var pairArray = [Int]()
    var counter = 0
    var timer = Timer()
    var score = 0
    var buttonArray = [UIImageView]()
    var placementArray = [Int]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialization of objects at start of game
        scoreLabel.text = "Score: \(score)"
        
        //creation of array that denotes how many buttons there are
        buttonArray = [button1, button2, button3, button4]
        
        //Display the fruit to be memorized
        assignFruit()
        
    }
    
    
    
    @objc func assignFruit() {
        //initialization of objects at start of game
        scoreLabel.text = "Score: \(score)"
        subtitle.text = "Memorize"
        counter = 5
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        //defining range and size of array
        //this is the chunk that needs to be changed in the harder difficulties
        let range = 1...4
        let size = 4
        //shuffles the numbers
        var numbers = Array(range).shuffled()
        //assigns the random numbers to an array
        let randomNumbers = Array(numbers.prefix(size))
        
        var i = 0
        for number in randomNumbers {
            if randomNumbers[i] == 1 || randomNumbers[i] == 2 {
                buttonArray[i].image = UIImage(named: "Apple")
            }
            
            if randomNumbers[i] == 3 || randomNumbers[i] == 4 {
                buttonArray[i].image = UIImage(named: "Orange")
            }
            i += 1
        }
        
        EasyGameViewController.pairArray = randomNumbers
        
        
    }
    
    //body
    @objc func countdown() {
        
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            recall()
            
            //signal move to the recall portion of the game
        }
        
    }
    
    @objc func recall() {
        
        subtitle.text = "Recall"
        
        for button in buttonArray {
            button.image = UIImage(named: "Basket")
        }
        
        var j = 0
        for i in buttonArray {
            let button = buttonArray[j]
            button.isUserInteractionEnabled = true
            button.tag = EasyGameViewController.pairArray[j]
            j += 1
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(makeChoice(tapGesture:)))
            button.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    @objc func makeChoice(tapGesture: UITapGestureRecognizer) {
        guard let tappedImageView = tapGesture.view as? UIImageView else {return}
        if subtitle.text == "Recall" {
            
            if firstGuess == 0 {
                if tappedImageView.tag == 1 || tappedImageView.tag == 2 {
                    tappedImageView.image = UIImage(named: "Apple")
                    standingGuessImage = "Apple"
                }
                
                if tappedImageView.tag == 3 || tappedImageView.tag == 4 {
                    tappedImageView.image = UIImage(named: "Orange")
                    standingGuessImage = "Orange"
                }
                previousGuess = tappedImageView.tag
                firstGuess += 1
                boardCount += 1
                print(boardCount)
                
            }
            
            else if tappedImageView.tag != previousGuess {
                if tappedImageView.tag == 1 || tappedImageView.tag == 2 {
                    tappedImageView.image = UIImage(named: "Apple")
                    if standingGuessImage != "Apple" {
                        youLose()
                    }
                    else {
                        accumulateScore()
                    }
                }
                
                if tappedImageView.tag == 3 || tappedImageView.tag == 4 {
                    tappedImageView.image = UIImage(named: "Orange")
                    if standingGuessImage != "Orange" {
                        youLose()
                    }
                    else {
                        accumulateScore()
                    }
                }
            }
        }
    }
    
    @objc func youLose() {
        subtitle.text = "You Lose"
        let alert = UIAlertController(title: "Match Failed", message: "You successfully matched \(score) fruits!!", preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "Quit", style: UIAlertAction.Style.cancel, handler: nil)
        let replayButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //processing of scores for high scores go here
            self.firstGuess = 0
            self.score = 0
            self.assignFruit()
        }
        
        alert.addAction(cancelButton)
        alert.addAction(replayButton)
        self.present(alert, animated:true, completion: nil)
    }
    
    @objc func accumulateScore() {
        //assign score here
        score += 1
        scoreLabel.text = "Score \(score)"
        firstGuess = 0
        //accumulate toward end of game
        boardCount += 1
        //check for end of game
        if boardCount == 4 {
            boardCount = 0
            resetBoard()
        }
    }
    
    @objc func resetBoard() {
        subtitle.text = "Get Ready"
        
        button1.image = UIImage(named: "Basket")
        button2.image = UIImage(named: "Basket")
        button3.image = UIImage(named: "Basket")
        button4.image = UIImage(named: "Basket")
        
        counter = 3
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(resetCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func resetCountdown() {
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            assignFruit()
            
        }
        
    }
}
