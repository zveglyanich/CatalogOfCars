//
//  CatalogViewController.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 19.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import UIKit
import RealmSwift

class CatalogViewController: UITableViewController {
    var listCars: Results<Cars>!
    var catalog: Results<CarInfo>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        importCatalogAndInitThreeCarToRealm()
        catalog = realm.objects(CarInfo.self)
        listCars = realm.objects(Cars.self)
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        listCars = realm.objects(Cars.self)
        catalog = realm.objects(CarInfo.self)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listCars.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarIdentifer", for: indexPath) as! CarViewCatalogCell
        let brandNameOfRealm = listCars[indexPath.row].brand!
        let endIndex = brandNameOfRealm.index(brandNameOfRealm.endIndex, offsetBy: -1)
        let brandNameImageForAssets = brandNameOfRealm.substring(to: endIndex)
        cell.carImageView.image = UIImage(named: brandNameImageForAssets)
        cell.carImageView.layer.cornerRadius = 5
        cell.imageView?.clipsToBounds = true
        cell.carBrandAndModelLabel.text = "\(brandNameImageForAssets) \(listCars[indexPath.row].model!)"
        cell.carYearLabel.text = String(listCars[indexPath.row].year)
        cell.carBodyLabel.text = listCars[indexPath.row].body!
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.deleteCar(listCars[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idCarForShow" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cdvc = segue.destination as! CarDetailViewController
                cdvc.carDetail = listCars[indexPath.row]
            }
        } else {
            let _ = segue.destination as! NewCarTableViewController
        }
    }
    
    
    private func importCatalogAndInitThreeCarToRealm() {
        if let path1 = Bundle.main.path(forResource: "brand", ofType: "txt"), let path2 = Bundle.main.path(forResource: "model", ofType: "txt"), realm.isEmpty == true {
            let text1 = try! String(contentsOfFile: path1)
            let text2 = try! String(contentsOfFile: path2)
            let brand: [String] = text1.components(separatedBy: "\n")
            let model: [String] = text2.components(separatedBy: "\n")
            for i in 0..<brand.count {
                if brand[i] != "" && model[i] != "" {
                    let car = CarInfo(value: [ i, brand[i], model[i]])
                    StorageManager.saveCarInfo(car)
                }
            }
            for index in 0..<3 {
                let results = importCatalog()
                let carInfo = results[results.count.arc4Random]
                let body = ["Universal", "Coupe", "Sedan", "Crossover", "Hatchback"]
                let car = Cars(value: [index, carInfo.brand!, carInfo.model!, body[body.count.arc4Random], 2010])
                StorageManager.saveCar(car)
            }
        }
    }
    
    private func importCatalog() -> Results<CarInfo> {
        let catalogInfo = StorageManager.importCatalog()
        return catalogInfo.objects(CarInfo.self)
    }
    
    @IBAction func closeAction(_ segue: UIStoryboardSegue) {}
}

extension Int{
    var arc4Random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
