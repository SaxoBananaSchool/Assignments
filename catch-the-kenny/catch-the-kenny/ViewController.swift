//
//  ViewController.swift
//  catch-the-kenny
//
//  Created by  on 4/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var shaqArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0
    
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var shaq1: UIImageView!
    @IBOutlet weak var shaq2: UIImageView!
    @IBOutlet weak var shaq3: UIImageView!
    @IBOutlet weak var shaq4: UIImageView!
    @IBOutlet weak var shaq5: UIImageView!
    @IBOutlet weak var shaq6: UIImageView!
    @IBOutlet weak var shaq7: UIImageView!
    @IBOutlet weak var shaq8: UIImageView!
    @IBOutlet weak var shaq9: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
        
        //High Score check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highscore = 0
            highScoreLabel.text = "High Score: \(highscore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highScoreLabel.text = "High Score: \(highscore)"
        }
        
        shaq1.isUserInteractionEnabled = true
        shaq2.isUserInteractionEnabled = true
        shaq3.isUserInteractionEnabled = true
        shaq4.isUserInteractionEnabled = true
        shaq5.isUserInteractionEnabled = true
        shaq6.isUserInteractionEnabled = true
        shaq7.isUserInteractionEnabled = true
        shaq8.isUserInteractionEnabled = true
        shaq9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        shaq1.addGestureRecognizer(recognizer1)
        shaq2.addGestureRecognizer(recognizer2)
        shaq3.addGestureRecognizer(recognizer3)
        shaq4.addGestureRecognizer(recognizer4)
        shaq5.addGestureRecognizer(recognizer5)
        shaq6.addGestureRecognizer(recognizer6)
        shaq7.addGestureRecognizer(recognizer7)
        shaq8.addGestureRecognizer(recognizer8)
        shaq9.addGestureRecognizer(recognizer9)
        
        shaqArray = [shaq1, shaq2, shaq3, shaq4, shaq5, shaq6, shaq7, shaq8, shaq9]
        
        //timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideShaq), userInfo: nil, repeats: true)
        
        hideShaq()
        
    }
    
    @objc func hideShaq() {
        for shaq in shaqArray {
            shaq.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(shaqArray.count - 1)))
        shaqArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countdown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for shaq in shaqArray {
                shaq.isHidden = true
            }
            
            //HighScore
            if self.score > self.highscore {
                self.highscore = self.score
                highScoreLabel.text = "High Score: \(self.highscore)"
                UserDefaults.standard.setValue(self.highscore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Think you can do better?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "No Way", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Perhaps", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideShaq), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }


}

