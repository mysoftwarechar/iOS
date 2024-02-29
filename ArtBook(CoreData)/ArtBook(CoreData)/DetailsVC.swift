//
//  DetailsVC.swift
//  ArtBook(CoreData)
//
//  Created by macpro on 13.02.2024.
//

import UIKit
import CoreData

class DetailsVC: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    //tableView'a veri aktarımı için
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Recognizers
        
        // ekrana dokunduğunda , klavyeyi kapatmak için
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //aşağıdaki kod sayesinde 'view'in herhangi bir yerine dokunduğunuzda çalışır.
        view.addGestureRecognizer(gestureRecognizer)
        
        
        //imageView'a dokunduğunda görsel seçmek için
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
        
        //tableView'a veri aktarımı için (adım 2)
        if chosenPainting != "" {
            
            //save buttton' u gizlemek için
            saveButton.isHidden = true
            
            
            //CoreData'dan data çekicem
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            //ilgili "id" üzerinden arayıp bulmak için yazılan fonksiyon
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
                
            } catch {
                print("error")
            }
        } else {
            // görünür ama tıklanamaz
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
        
        
    }
    
    // ekrana dokunduğunda , klavyeyi kapatmak için , ilgili @objc fonksiyonu
    @objc func hideKeyboard(){
        //'endEditing' metodu kullanıldığında , bir view içerisinde ki yapılan değişikler son bulunur . örneğin klavye açıldıysa kapatılır.
        view.endEditing(true)
    }
    
    
    //imageView'a dokunduğunda görsel seçmek için ilgili @objc fonksiyonu
    @objc func selectImage(){
        
        // fotoğraflara erişmek için 'picker' kullanıyoruz.
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        // kullanıcı seçtiği görseli editlemek istiyorsa ( kemek, kırpmak vs)
        picker.allowsEditing = true
        // present = sunmak
        present(picker, animated: true, completion: nil)
        
    }
    
    //resmi seçtikten sonra ne olucağını seçmek(belirlemek) için
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        //resim seçildikten sonra save button görünürlüğünü açmak için
        saveButton.isEnabled = true
        //picker'i kapatmak için
        self.dismiss(animated: true, completion: nil)
    }


    //verileri CoreData'ya kaydetmek için
    @IBAction func saveClicked(_ sender: Any) {
        // bu kısım ezber . her seferinde aynı.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //context'in içine ne koyulucağını belirlemek için
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        
        //Attributes
        //name
        newPainting.setValue(nameText.text! , forKey: "name")
        //artist
        newPainting.setValue(artistText.text! , forKey: "artist")
        //year
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        //id
        newPainting.setValue(UUID(), forKeyPath: "id")
        //image
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        
        //verileri kaydetmek için
        do {
            try context.save()
            print("succes")
        } catch {
            print("error")
        }
        
        
        //işim bittikten sonra viewController'a gitmek için
        self.navigationController?.popViewController(animated: true)
        
        //yeni eklenen verileri tableView'da görüntülemek için(devamı ViewController'da)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        
        
        
    }
    
    
    
    
    
    
    
}
