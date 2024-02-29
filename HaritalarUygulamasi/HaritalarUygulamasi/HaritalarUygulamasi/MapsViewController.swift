//
//  ViewController.swift
//  HaritalarUygulamasi
//
//  Created by macpro on 29.12.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapsViewController: UIViewController ,MKMapViewDelegate ,CLLocationManagerDelegate {
    

    @IBOutlet weak var notTextField: UITextField!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var secilenLatitude = Double()
    var secilenLongitude = Double()
    
    var secilenIsim = ""
    var secilenId : UUID?
    
    var annotationTittle = ""
    var annotationSubtittle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
//        3 sn. basılı tuttuğunda pin iğnesi göstermek için:
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(konumSec(gestureRecognizer: )))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if secilenIsim != ""{
            // Core Data'dan verileri çek
            if let uuidString = secilenId?.uuidString{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Yer")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                
                do{
                    
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0 {
                        for sonuc in sonuclar as! [NSManagedObject] {
                            if let isim = sonuc.value(forKey: "isim") as? String {
                                annotationTittle = isim
                                
                                if let not = sonuc.value(forKey: "not") as? String {
                                    annotationSubtittle = not
                                    
                                    if let latitude = sonuc.value(forKey: "latitude") as? Double {
                                        annotationLatitude = latitude
                                        
                                        if let longitude = sonuc.value(forKey: "longitude") as? Double {
                                            annotationLongitude = longitude
                                            
                                            
                                            // şayet bütün if'ler eksizsiz çalışırsa
                                            // ancak o zaman aşağıda ki kodlar çalışır...
                                            let annotation = MKPointAnnotation()
                                            annotation.title = annotationTittle
                                            annotation.subtitle = annotationSubtittle
                                            let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                            annotation.coordinate = coordinate
                                            
                                            mapView.addAnnotation(annotation)
                                            isimTextField.text = annotationTittle
                                            notTextField.text = annotationSubtittle
                                            
                                            locationManager.stopUpdatingLocation()
                                            
                                            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                            
                                            let region = MKCoordinateRegion(center: coordinate, span: span)
                                            mapView.setRegion(region, animated: true)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    
                }catch{
                    print("hata")
                }
                
                
            }
        }else {
            //yeni veri eklemeye geldi
        }
        
        
    }
    @objc func konumSec(gestureRecognizer : UILongPressGestureRecognizer){
        
//      jest algılayıcı başladığında ;
        if gestureRecognizer.state == .began {
            let dokunulanNokta = gestureRecognizer.location(in: mapView)
            let dokunulanKoordiat = mapView.convert(dokunulanNokta, toCoordinateFrom: mapView)
            
            secilenLatitude = dokunulanKoordiat.latitude
            secilenLongitude = dokunulanKoordiat.longitude
            
            
//            işaretleme işlemi için;
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = dokunulanKoordiat
            annotaion.title = isimTextField.text
            annotaion.subtitle = notTextField.text
            mapView.addAnnotation(annotaion)
            
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if secilenIsim == "" {
            //        print(locations[0].coordinate.latitude)  //enlem bilgileri
            //        print(locations[0].coordinate.longitude) //boylam bilgiler
                    let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            //        yukarıda ki 0.1 değerleri hakkında:
            //        yakından görmek istiyorsan küçük değer gir
            //        uzaktan görmek istiyorsan büyük değer gir
                    let region = MKCoordinateRegion(center: location, span: span)
                    mapView.setRegion(region, animated: true)
        }
    }

    
    
    
    
    @IBAction func kaydetTiklandi(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let yeniYer = NSEntityDescription.insertNewObject(forEntityName: "Yer", into: context)
        
        yeniYer.setValue(isimTextField.text, forKey: "isim")
        yeniYer.setValue(notTextField.text, forKey: "not")
        yeniYer.setValue(secilenLatitude, forKey: "latitude")
        yeniYer.setValue(secilenLongitude, forKey: "longitude")
        yeniYer.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("kayit edildi")
        } catch{
            print("hata")
        }
        
        
    }
    
}

