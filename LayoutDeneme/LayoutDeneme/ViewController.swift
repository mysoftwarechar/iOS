//
//  ViewController.swift
//  LayoutDeneme
//
//  Created by macpro on 3.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
// aşağıdaki satır ekranın genişlik değerini width değişkenine atıyor.
        let width = view.frame.size.width
// aşağıdaki satır ekranın uzuluk değerini height değişkenine atıyor.
        let height = view.frame.size.width
        
//        Label
        let myLabel = UILabel()
        myLabel.text = "Test Label"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.5 - 50 , y: height * 0.5 + 150 , width: 100 , height: 100)
        view.addSubview(myLabel)
        
        
//        Button
        let myButton = UIButton()
        myButton.setTitle("Benim Butonum", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: width * 0.5 - 100 , y: height * 0.5 + 200 , width: 200 , height: 100)
        view.addSubview(myButton)
        
        
        
        
        
        
        
        
    }


}

