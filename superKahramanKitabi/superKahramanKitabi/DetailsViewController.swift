//
//  DetailsViewController.swift
//  superKahramanKitabi
//
//  Created by macpro on 10.10.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var secilenKahramanIsmi = ""
    var secilenKahramanGorselIsmi = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: secilenKahramanGorselIsmi)
        label.text = secilenKahramanIsmi
        
    }
    



}
