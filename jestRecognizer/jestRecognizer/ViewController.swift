//
//  ViewController.swift
//  jestRecognizer
//
//  Created by macpro on 9.02.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var isFenerbahce1 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        imageView.addGestureRecognizer(gestureRecognizer)


    }
    
    @objc func changePic() {

        if isFenerbahce1 == true {
            imageView.image = UIImage(named: "fb2")
            label.text = "2"
            isFenerbahce1 = false
        } else {
            imageView.image = UIImage(named: "fb1")
            label.text = "1"
            isFenerbahce1 = true
        }
        
        
     
    }
    


}

