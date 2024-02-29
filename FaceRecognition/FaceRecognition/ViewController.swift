//
//  ViewController.swift
//  FaceRecognition
//
//  Created by macpro on 24.02.2024.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //FaceID doğrulama fonksiyonu
    @IBAction func faceIDClicked(_ sender: Any) {
        //info.plisst ayarını yapmayı unutma.
        //kılavuz:
        //info.plist->Privacy - Face ID Usage Description->To Authenticate
        
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") {
                (success, error) in
                if success == true {
                    //successful auth
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        //faceID doğrulanmazsa buraya yazdığın şart gerçekleşir
                    }
                }
            }
        }
    }
    
    
    
    
}

