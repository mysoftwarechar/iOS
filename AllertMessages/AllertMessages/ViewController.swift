//
//  ViewController.swift
//  AllertMessages
//
//  Created by macpro on 9.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupClicked(_ sender: Any) {
        
        if usernameText.text == "" {
            
            makeAlert(titleInput: "Error!", messageInput: "username not found")
            
        } else if passwordText.text == "" {
            
            makeAlert(titleInput: "Error!", messageInput: "password not found")
            
        } else if passwordText.text != passwordAgainText.text {
            
            makeAlert(titleInput: "Error!", messageInput: "password do not match!")
            
        } else {
            
            makeAlert(titleInput: "Succesful!", messageInput: "user creating ssuccesful.")
            
        }
    }
    
    //Alert(uyarı) mesajları fonksiyonu.  bu fonksiyonu çağırarak kullanabilirsin
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}

