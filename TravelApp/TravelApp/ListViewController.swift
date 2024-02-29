//
//  ListViewController.swift
//  TravelApp
//
//  Created by macpro on 24.02.2024.
//

import UIKit
import CoreData
import LocalAuthentication

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var idArray = [UUID]()
    var chosenTitle = ""
    var chosenTitleId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bu VC'm dark mode'da çalıştırmak istersem
        //overrideUserInterfaceStyle = .dark
        
        //Dark mode'u tamamen bütün app'ime uygulamak istersem izlemem gereken adımlar
        //dosyalarım->info.plist->yeni oluştur->User Inter faceStyle->karşısına 'Dark' yaz.
        
        
        
        //sağ üste '+' buttonu eklemek için
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    //ince ayarlar(1/2)
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    //verileri göstermek için ilgili fonksiyon
    @objc func getData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                //diziye eleman atmadan önce içini temizliyoruz.
                self.titleArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    
                    //tittleArray dizisine ilgili title'i eklemek için
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                    
                    //idArray dizisine ilgili id'i eklemek için
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    //tableView'in içinde göstermek için
                    tableView.reloadData()
                    
                }
                
            }
            
            
        } catch {
            print("error")
        }
        
    }
    
    //sağ üste '+' buttonu eklemek için ilgili @objc func
    @objc func addButtonClicked() {
        chosenTitle = ""
        //performSegue ile ilgili VC'e gidiyoruz
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = titleArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    //seçili satıra şunu yap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //info.plisst ayarını yapmayı unutma.
        //kılavuz:
        //info.plist->Privacy - Face ID Usage Description->To Authenticate
        
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") {
                (success, error) in
                if success == true {
                    //successful auth
                    DispatchQueue.main.async {
                        
                        
                        self.chosenTitle = self.titleArray[indexPath.row]
                        self.chosenTitleId = self.idArray[indexPath.row]
                        self.performSegue(withIdentifier: "toViewController", sender: nil)
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        //faceID doğrulanmazsa buraya yazdığın şart gerçekleşir
                    }
                }
            }
        }
        
        
        
        
        
     
        
    }
    
    //ilgili VC'e 'title' ve'id' bilgilerini gönder.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.selectedTitle = chosenTitle
            destinationVC.selectedTitleID = chosenTitleId
            
        }
    }
    
    
    
    //tableView'dan verileri silmek için
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            //fetchRessguest oluşturucaz. ve ilgili veriyi silicez
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            
            let idString = idArray[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@",idString )
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArray[indexPath.row]{
                                context.delete(result)
                                titleArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                //aradığım şeyi bulduysam ve sildiysem 'break' diyorum ve for loop'u sonlandırıyorum.
                                break
                                
                            }
                        }
                    }
                }
                
            } catch {
                print("error")
            }
            
        }
    }
    // delete func burda bitti
    

    

}
