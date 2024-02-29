//
//  ViewController.swift
//  SehirTanitimKitabi
//
//  Created by macpro on 16.10.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var sehirDizisi = [Sehir]()
    var kullaniciSecimi : Sehir?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //Sehirler
        
        let istanbul = Sehir(isim: "istanbul", bolge: "marmara bolgesi", gorsel: UIImage(named: "istanbul")!)
        
        let ankara = Sehir(isim: "ankara", bolge: "ic anadolu bolgesi", gorsel: UIImage(named: "ankara")!)
        
        let izmir = Sehir(isim: "izmir", bolge: "ege bolgesi", gorsel: UIImage(named: "izmir")!)
        
        let diyarbakir = Sehir(isim: "diyarbakir", bolge: "güney dogu bolgesi", gorsel: UIImage(named: "diyarbakır")!)
        
        let antalya = Sehir(isim: "antalya", bolge: "akdeniz bolgesi", gorsel: UIImage(named: "antalya")!)
        
        sehirDizisi = [istanbul,ankara,izmir,diyarbakir,antalya]
        
        
        
    }
    
    // tableView'in satır sayısını ifade eder.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sehirDizisi.count
    }
    
    
    // seçili satırda ne gözükmesini istiyorsun
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.textLabel?.text = sehirDizisi[indexPath.row].isim
        var content = cell.defaultContentConfiguration()
        content.text = sehirDizisi[indexPath.row].isim
        content.secondaryText = sehirDizisi[indexPath.row].bolge
        cell.contentConfiguration = content
        return cell
    }
    
    //tableView'da bir row select edildiğinde yapılması gereken.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        kullaniciSecimi = sehirDizisi[indexPath.row]
        //performSegue ile diğer ekrana gidiyoruz.
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    //prepare for segue ile 'DetailsViewController'a data gönderiyoruz.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            //destinationVC'nin secilenSehir isimli nesnesini = "kullaniciSecimi"ne eşitledik
            destinationVC.secilenSehir = kullaniciSecimi
        }
    }
    
    //tableView'dan bir şey silmek için kullanılır.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.sehirDizisi.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    
    
}

