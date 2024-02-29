//
//  ViewController.swift
//  uyariMesajlari
//
//  Created by macpro on 8.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signUpTiklandi(_ sender: Any) {

        if emailTextField.text == "" {
            //emailini girmemişssin.
            alertOlustur(titleGirdisi: "Hata mesajı!", messageGirdisi: "Lütfen E-mail giriniz.")
            
        } else if passwordTextField.text == "" {
            //parolanı girmemişssin.
            alertOlustur(titleGirdisi: "Hata mesajı!", messageGirdisi: "Lütfen parola giriniz.")
            
        } else if passwordTextField.text != password2TextField.text {
            //parolaların birbiriyle uyuşmuyor.
            alertOlustur(titleGirdisi: "Hata mesajı!", messageGirdisi: "Parolalar uyuşmuyor.")
            
        } else {
            //kayıt başarılı.
            alertOlustur(titleGirdisi: "Succesful!", messageGirdisi: "Kayıt başarılı.")
            
        }
    }
    
    
    func alertOlustur(titleGirdisi : String , messageGirdisi : String){
        let uyariMesaji = UIAlertController(title: titleGirdisi, message: messageGirdisi, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
            //OK Button'una tıklanınca olacaklar
            print("ok button tiklandi")
        }
        
        uyariMesaji.addAction(okButton)
        
        //Bunu kullanıcıya göstermek istersek "present" diyeceğiz.
        //view controller içerisinde olduğumuz için "present" yerine,
        //"self.present" yazmakta fayda var
        self.present(uyariMesaji, animated: true, completion: nil)
    }
}

