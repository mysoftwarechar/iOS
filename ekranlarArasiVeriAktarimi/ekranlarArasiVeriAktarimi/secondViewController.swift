//
//  secondViewController.swift
//  ekranlarArasiVeriAktarimi
//
//  Created by macpro on 4.02.2024.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var myName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = myName
    }
    

}
