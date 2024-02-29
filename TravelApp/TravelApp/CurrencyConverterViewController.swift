//
//  CurrencyConverterViewController.swift
//  TravelApp
//
//  Created by macpro on 27.02.2024.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    

    //Döviz çevirici API
    @IBAction func getRatesClicked(_ sender: Any) {
        
        //3 adımımız var
        //1-)Request & Session : yani internete gidip URL'ye istek yollamak
        //2-)Response veya Data'yı almak
        //3-)Parsing veya JSON Serialization : yani bu data'yı işlemek
        
        //1. adım
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9cc541b9f4c236c7027ef41f3c3a58a3")
        
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //2.adım
                if data != nil {
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tl)"
                                }

                                
                                
                                
                            }
                        }
                        
                        
                    } catch{
                        print("error")
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }
        //işlemi başlatmak için
        task.resume()
        
        
        
        
    }
    

}
