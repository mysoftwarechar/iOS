//
//  ViewController.swift
//  TravelApp
//
//  Created by macpro on 24.02.2024.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveButton: UIButton!
    
    
   
    //kullanıcının konumu ile ilgili işlemler yapmak için
    var locationManager = CLLocationManager()
    var chosenLatitude = 0.00000000001
    var chosenLongitude = 0.00000000001
    
    var selectedTitle = ""
    var selectedTitleID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bu VC'm dark mode'da çalıştırmak istersem
        //overrideUserInterfaceStyle = .dark
        
        
        //mapView'in delegasyonunu ViewController'a vermek için
        mapView.delegate = self
        //locationManager'in delegasyonunu ViewController'a vermek için
        locationManager.delegate = self
        //konumun verisi ne kadar keskin ve net olsun.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //kullanıcının konumunu kullanmak için izin almak için(info plist'ten izni ayarlaman gerek)
        locationManager.requestWhenInUseAuthorization()
        //kullanıcının yerini bu kelieyle birlikte alaya başlıyoruz.
        locationManager.startUpdatingLocation()
        
        
        //Recognizers
        
        // ekrana dokunduğunda , klavyeyi kapatmak için
        let gestureRecognizerKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //aşağıdaki kod sayesinde 'view'in herhangi bir yerine dokunduğunuzda çalışır.
        view.addGestureRecognizer(gestureRecognizerKeyboard)
        
        
        
        
        //Pinleme yapmak için(3n basılı tutunca) [1 tane de @objc func var]
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        //imageView'a dokunduğunda görsel seçmek için
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
        
        
        if selectedTitle != "" {
            
            //save button is hidden
            saveButton.isHidden = true
            
            //CoreData'dan veri çekip , verileri yerine yerleştiricez.
          
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let title = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                                
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    
                                    if let longitude = result.value(forKey: "longitude") as? Double {
                                        annotationLongitude = longitude
                                        
                                        if let imageData = result.value(forKey: "image") as? Data {
                                            let image = UIImage(data: imageData)
                                            imageView.image = image
                                            
                                            
                                            let annotation = MKPointAnnotation()
                                            annotation.title = annotationTitle
                                            annotation.subtitle = annotationSubtitle
                                            let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                            annotation.coordinate = coordinate
                                            
                                            mapView.addAnnotation(annotation)
                                            nameText.text = annotationTitle
                                            commentText.text = annotationSubtitle
                                            
                                            
                                            //harita'da kayıtlı pinin yerini göstermek için
                                            locationManager.stopUpdatingLocation()
                                            //zoom ayarı
                                            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                            //harita'da kayıtlı pinin yerini göstermek için
                                            let region = MKCoordinateRegion(center: coordinate, span: span)
                                            mapView.setRegion(region, animated: true)
                                        }
                                    }
                                }
             
                            }
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
    
    
    
    
    //Pinleme yapmak için(3n basılı tutunca)
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer) {
        
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            //pin(annotation)'u oluşturmak için
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
            
        }
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
    
    //kullanıcının güncellenen lokasyonları 'CLLocation' adında ki dizi içinde bize veriyor.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //kayıtlı pinin yerini göstermek için (if selectedTitle == ""{}) yazarak bu ayarı yapmalıyız .çünkü bu ayarı yapmazsak bazı senkronizasyon hatalarına sebep olabilir.
        if selectedTitle == "" {
            //enlem ve boylam değerlerini girip(kullanıcı konumunu çekip) bir ,'location' oluştur.
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            //zoom seviyesine 'span'denir. (yakınlık , uzaklık)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            //bölgeyi ayarlamak için
        let region = MKCoordinateRegion(center: location, span: span)
            //mapView'a konumu set etmek için
        mapView.setRegion(region, animated: true)
        } else {
            //
        }
    }
    
    //(Annotation)pin'i özelleştirmek için (haritalara gitmek için)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //kullanıcının yerini pin ile göstermek İSTEMİYORSAN
        if annotation is MKUserLocation {
            return nil
        }
        
        
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            //ekstra bilgi gösterebilmek için için açılan baloncuk
            pinView?.canShowCallout = true
            //pin rengini özelleştirmek için
            pinView?.tintColor = UIColor.black
            
            //açılan baloncukta 'button' oluşturmak için
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            //sağ tarafında gösterilecek görünümde bu 'button'u göster.
            pinView?.rightCalloutAccessoryView = button
            
        } else {
            // else = pinView boş değilse , yani daha önce oluşturulduysa
            pinView?.annotation = annotation
        }
        
        
        
        return pinView
    }
    
    //haritalar,a gitmek için (ilgili 'i' buttonuna tıklandığında haritalara gitmek için gerekli fonksiyon
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //eğer seçilmiş veri varsa o zaman çalış
        if selectedTitle != "" {
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            //navigasyonumu çalıştırmak için gerekli olan objeyi alabilmek için
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                //yukarıda yapılan koda 'closure' denir.
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                                      
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                                      
                }
            }
        }
            
            
        }
    
    
    
    
    }
    
    
    


    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        
            //boş bir şekilde kaydedersem UYARI MESAJI oluşturmak için
            if nameText.text == "" {
                //makeAlert func , uyarı messajı oluşturur. aşağıda tanımladım.
                makeAlert(titleInput: "Error!", messageInput: "Place name is not found")
                
            } else if commentText.text == "" {
                
                makeAlert(titleInput: "Error!", messageInput: "Comment is not found")
                
            } else if chosenLatitude == 0.00000000001 {
                makeAlert(titleInput: "Error", messageInput: "Location is not found")
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
                
                //name
                newPlace.setValue(nameText.text, forKey: "title")
                //comment
                newPlace.setValue(commentText.text, forKey: "subtitle")
                //enlem
                newPlace.setValue(chosenLatitude, forKey: "latitude")
                //boylam
                newPlace.setValue(chosenLongitude, forKey: "longitude")
                //id
                newPlace.setValue(UUID(), forKey: "id")
                //image
                let data = imageView.image?.jpegData(compressionQuality: 0.5)
                newPlace.setValue(data, forKey: "image")
        
                
                do {
                    try context.save()
                    print("success")
                } catch {
                    print("error")
                }
                
                //ince ayarlar (2/2)
                NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
                //bir önceki VC'e geri gitmek için
                navigationController?.popViewController(animated: true)
            }
        
        
        
        
    }
    
    
    
    
    
    
    //Alert(uyarı) mesajları fonksiyonu.  bu fonksiyonu çağırarak kullanabilirsin
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

