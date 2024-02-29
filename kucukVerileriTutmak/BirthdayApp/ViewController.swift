//
//  ViewController.swift
//  BirthdayApp
//
//  Created by macpro on 4.02.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uygulama açılır açılmaz viewDidLoad() fonksiyonu çalışır...
        //uygulama açılır açılmaz sakladığımız verilerin label'da gözükmesini istiyorsak
        //bu şekilde yapmalıyız.
        
        //sakladığın verileri bu şekilde geri kullanabilirsin
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        // casting yapmamız gerek ..[as!  vs    as?]
        //string gelmeme ihtimaline karşın opsiyonel(as?) yapıcaz.
        if let newName = storedName as? String {
            //bu kod şu anlama geliyor:
            //storedName eğer string ise , onu newName'e ata ve aşağıdaki komutu yap.
            nameLabel.text = newName
        }
        
        if let newBirthday = storedBirthday as? String {
            birthdayLabel.text = newBirthday
        }
    }

    @IBAction func kaydetTiklandi(_ sender: Any) {
        // ufak verileri bu şekilde saklayabilirsin.
        UserDefaults.standard.set(nameText.text!, forKey: "name")
        UserDefaults.standard.set(birthdayText.text!, forKey: "birthday")
//        UserDefaults.standard.synchronize()
        
        
        nameLabel.text = "Name : \(nameText.text!)"
        birthdayLabel.text = "Birthday : \(birthdayText.text!)"
        
    }
    
    @IBAction func deleteTiklandi(_ sender: Any) {
        
        //UserDefaults'a kaydedilen veri aşağıda gösterildiği gibi silinir.
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if storedName is String {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name : "
        }
        
        if storedBirthday is String {
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Name :"
        }
    
        
//        aşağıda ki şekilde de bu işlem gerçekleştirilebilir...
//        if (storedName as? String) != nil{
//            UserDefaults.standard.removeObject(forKey: "name")
//            nameLabel.text = ""
//        }

        
        
        
    }
}

