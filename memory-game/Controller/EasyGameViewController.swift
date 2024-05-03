//
//  EasyGameViewController.swift
//  memory-game
//
//  Created by  on 4/30/24.
//

import UIKit

class EasyGameViewController: UIViewController {
    
    //views
    @IBOutlet weak var button1: UIImageView!
    @IBOutlet weak var button2: UIImageView!
    @IBOutlet weak var button3: UIImageView!
    @IBOutlet weak var button4: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //variables
    var counter = 0
    var timer = Timer()
    var score = 0
    var buttonArray = [UIImageView]()
    var placementArray = [Int]()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialization of objects at start of game
        subtitle.text = "Memorize"
        scoreLabel.text = "Score: \(score)"
        livesLabel.text = "Lives: X X X"
        
        buttonArray = [button1, button2, button3, button4]
        
        //Display the fruit to be memorized
        assignFruit()
        
        print(placementArray) pickup from here where all the errors are you just need the random numbers to be unique
        
        //timer
        counter = 5
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
    }
    
    @objc func assignFruit() {
        
        for button in buttonArray {
            let random = Int(arc4random_uniform(UInt32(buttonArray.count - 1)))
            placementArray.append(random)
            
        }
        
    }
    
    //body
    @objc func countdown() {
        
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            
            subtitle.text = "Recall"
            
            
        }
        
    }

}
