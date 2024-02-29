//
//  ViewController.swift
//  timer
//
//  Created by macpro on 9.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        myLabel.text = "Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)

    }
    
    @objc func timerFunction(){
        
        myLabel.text = "Time : \(counter)"
        counter -= 1
        
        if counter == 0{
            timer.invalidate()
            myLabel.text = "Time's Over"
        }
        
        
        
    }

    @IBAction func buttonClicked(_ sender: Any) {
    }
    
}

