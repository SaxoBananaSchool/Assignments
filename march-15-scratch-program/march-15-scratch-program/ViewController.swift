//
//  ViewController.swift
//  march-15-scratch-program
//
//  Created by  on 3/15/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var birthdayField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedName = UserDefaults.standard.object(forKey: "Name")
        let storedBirthday = UserDefaults.standard.object(forKey: "Birthday")
        
        if let newName = storedName as? String
        {
            nameLabel.text = "name \(newName)"
        }
        
        if let newBirthday = storedBirthday as? String
        {
            birthdayLabel.text = "birthday \(newBirthday)"
        }
        
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        UserDefaults.standard.setValue(nameField.text!, forKey: "name")
        
        UserDefaults.standard.setValue(birthdayField.text!, forKey: "birthday")
        nameLabel.text = "Name: \(nameField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayField.text!)"
        
        
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    }




