//
//  CarListInfoViewController.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 20.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var carDetail: Cars?
    private var allCellsCarsTextField = [UITextField]()
    @IBOutlet weak var carOfListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Характеристики"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let brand = allCellsCarsTextField[0].text, let model = allCellsCarsTextField[1].text,let year = Int(allCellsCarsTextField[2].text!), let body = allCellsCarsTextField[3].text else { return }
        if carDetail == nil {
            var maxId = realm.objects(Cars.self).map{$0.id}.max() ?? 0
            maxId = maxId + 1
            let newCar = Cars(value: [maxId, brand, model, body, year])
            StorageManager.saveCar(newCar)
            navigationController?.popViewController(animated: true)
        } else {
            guard let updatedCar = realm.objects(Cars.self).filter("id == \(carDetail!.id)").first else { return }
            try! realm.write {
                updatedCar.brand = brand
                updatedCar.model = model
                updatedCar.body = body
                updatedCar.year = year
            }
            navigationController?.popViewController(animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarIdentifer", for: indexPath) as! CarDetailTableViewCell
        allCellsCarsTextField.append(cell.carValueCharacterTextField)
        switch indexPath.row {
        case 0 :
            cell.carCharacterLabel.text = "Марка"
            cell.carValueCharacterTextField.text = carDetail?.brand
        case 1 :
            cell.carCharacterLabel.text = "Модель"
            cell.carValueCharacterTextField.text = carDetail?.model
        case 2 :
            cell.carCharacterLabel.text = "Год"
            let year = carDetail?.year
            cell.carValueCharacterTextField.text = String(year!)
        case 3 :
            cell.carCharacterLabel.text = "Кузов"
            cell.carValueCharacterTextField.text = carDetail?.body
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
