//
//  ViewController.swift
//  SimpsonBookOOP
//
//  Created by macpro on 13.02.2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate ,  UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var mySimpson = [Simpson]()
    var chosenSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Simpson Objects
        
        let homer = Simpson(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "homer")!)
        
        let marge = Simpson(name: "Marge Simpson", job: "HouseWife", image: UIImage(named: "marge")!)
        
        let bart = Simpson(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart")!)
        
        let lisa = Simpson(name: "Lisa Simpson", job: "Student", image: UIImage(named: "lisa")!)
        
        let maggie = Simpson(name: "Maggie Simpson", job: "Baby", image: UIImage(named: "maggie")!)
        
        
        mySimpson.append(homer)
        mySimpson.append(marge)
        mySimpson.append(bart)
        mySimpson.append(lisa)
        mySimpson.append(maggie)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content  = cell.defaultContentConfiguration()
        content.text = mySimpson[indexPath.row].name
        content.secondaryText = mySimpson[indexPath.row].job
        cell.contentConfiguration = content
        return cell
    }

    // ilgili satır tıklandığında şunu yap.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenSimpson = mySimpson[indexPath.row]
        
        // bu kod ile ilgili ViewController'a gidilir.
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // segue'ye hazırlan.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    

}

