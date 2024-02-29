//
//  ViewController.swift
//  ekranlarArasiVeriAktarimi
//
//  Created by macpro on 4.02.2024.
//

import UIKit

class ViewController: UIViewController {

    var userName = ""
    
    @IBOutlet weak var nameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextClicked(_ sender: Any) {
        
        userName = nameText.text!
        
        //bu VC'den diğer VC'e gitmek için:
        performSegue(withIdentifier: "toSecondVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC"{
//            as! --- casting yaptık
            let destinationVC = segue.destination as! secondViewController
            destinationVC.myName = userName
        }
    }
    
}

