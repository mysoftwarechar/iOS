//
//  ViewController.swift
//  jestAlgilayicilar
//
//  Created by macpro on 8.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselDegistir))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }

    
    @objc func gorselDegistir(){
        
        if case label.text = "Bahariye" {
            
            imageView.image = UIImage(named: "site_0356_0047-750-750-20151105154645")
            label.text = "kiz kulesi"
            
        } else if case label.text = "kiz kulesi" {
            
            imageView.image = UIImage(named: "kadikoy")
            label.text = "Bahariye"
            
        }
        
        

        
    }
    

}

