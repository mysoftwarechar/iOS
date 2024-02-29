//
//  ViewController.swift
//  ArtBook(CoreData)
//
//  Created by macpro on 13.02.2024.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    //CoreData'dan veri çekmek için
    var nameArray = [String]()
    var idArray = [UUID]()
    
    //tableView'a veri aktarımı için (adım 3)
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sağ üste 'add' button'u eklemek için bu kod yazılır.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        
        
        
        //CoreData'dan veri çekmek için
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        
        
        
        
        
    }
    
    //yeni eklenen verileri tableView'da görüntülemek için (adım2)
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    
    
    //sağ üste 'add' button'u eklemek için yazılması gereken @objc fonksiyonu
    @objc func addButtonClicked(){
        selectedPainting = ""
        
        // 'add' button'u click edildiğinde bizi 'toDetailsVC'e götür.
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    //CoreData'dan veri çekmek için
    //kaç tane satır olacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    //her satırda ne olacak
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    //Data'yı çekmek için ilgili fonksiyon
    @objc func getData() {
        //yeni eklenen verileri tableView'da görüntülerken , geçmişteki verileri de tekrar tekrar yazdırmamak için aşağıdaki 2 satır kodu yazmalısın
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                
                //CoreData model objesi olarak tek tek verileri çekmek için
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID  {
                        self.idArray.append(id)
                    }
                    
                    //veri ekledikten sonra tableView'i refresh edip yeni verileri görmek için
                    self.tableView.reloadData()
                    
                }
                
            }
            
            
            
        } catch {
            print("error")
        }
        
    }
    
    
    
    
    //tableView'a veri aktarımı için (adım 4)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC =  segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    //bir veriye tıklandığında ne yapacağımızı belirlemek için
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
    
    //tableView'dan verileri silmek için
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            //fetchRessguest oluşturucaz. ve ilgili veriyi silicez
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
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
                                nameArray.remove(at: indexPath.row)
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

