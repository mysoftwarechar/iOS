//
//  ViewController.swift
//  viewControllerProjesi
//
//  Created by macpro on 4.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var birinciLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var alinanID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        textField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
    }
    

    @IBAction func kontrolEtTiklandi(_ sender: Any) {
        alinanID = textField.text!
        
        if alinanID == "yanakların"{
            performSegue(withIdentifier: "toSecondVC", sender: nil)
        } else {
            birinciLabel.text = "parola yanlış"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! ikinciViewController
            destinationVC.verilenID = alinanID
        }
    }
    
    
    
    
}

