//
//  ViewController.swift
//  userDefaultsProject
//
//  Created by macpro on 4.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notTextField: UITextField!
    @IBOutlet weak var zamanTextField: UITextField!
    @IBOutlet weak var notLabel: UILabel!
    @IBOutlet weak var zamanLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kaydedilenNot = UserDefaults.standard.object(forKey: "not")
        let kaydedilenZaman = UserDefaults.standard.object(forKey: "zaman")
        
        if let gelenNot = kaydedilenNot as? String{
            notLabel.text = "Yapılacak iş : \(gelenNot)"
        }
        
        if let gelenZaman = kaydedilenZaman as? String{
            zamanLabel.text = "Yapılacak zaman : \(gelenZaman)"
        }
        
    }

    
    @IBAction func kaydetTiklandi(_ sender: Any) {
        
        UserDefaults.standard.set(notTextField.text!, forKey: "not")
        UserDefaults.standard.set(zamanTextField.text!, forKey: "zaman")
        
        notLabel.text = "Yapılacak iş : \(notTextField.text!)"
        zamanLabel.text = "Yapılacak zaman : \(zamanTextField.text!)"
        
    }
    
    
    @IBAction func silTiklandi(_ sender: Any) {
        
        let kaydedilenNot = UserDefaults.standard.object(forKey: "not")
        let kaydedilenZaman = UserDefaults.standard.object(forKey: "zaman")
        
        if (kaydedilenNot as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "not")
            notLabel.text = "Yapılacak iş : "
        }
        
        if (kaydedilenZaman as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "zaman")
            zamanLabel.text = "Yapılacak zaman : "
        }
    }
    
    
    

}

