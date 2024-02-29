//
//  ViewController.swift
//  notlarim
//
//  Created by macpro on 26.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstText: UITextField!
    
    @IBOutlet weak var secondText: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func artiTiklandi(_ sender: Any) {
        
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                let result = firstNumber + secondNumber
                resultLabel.text = String(result)
            } else {
                resultLabel.text = "Please enter integer!!!"
            }
        } else {
            resultLabel.text = "Please enter integer!!!"
        }
        
        
    }
    
    @IBAction func eksiTiklandi(_ sender: Any) {
        
        
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                let result = firstNumber - secondNumber
                resultLabel.text = String(result)
            } else {
                resultLabel.text = "Please enter integer!!!"
            }
        } else {
            resultLabel.text = "Please enter integer!!!"
        }
        
        
    }
    
    @IBAction func carpiTiklandi(_ sender: Any) {
        
        
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                let result = firstNumber * secondNumber
                resultLabel.text = String(result)
            } else {
                resultLabel.text = "Please enter integer!!!"
            }
        } else {
            resultLabel.text = "Please enter integer!!!"
        }
        
        
    }
    
    @IBAction func boluTiklandi(_ sender: Any) {
        
        
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                let result = firstNumber / secondNumber
                resultLabel.text = String(result)
            } else {
                resultLabel.text = "Please enter integer!!!"
            }
        } else {
            resultLabel.text = "Please enter integer!!!"
        }
        
        
    }
    
}

