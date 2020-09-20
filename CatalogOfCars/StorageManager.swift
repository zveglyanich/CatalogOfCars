//
//  StorageManager.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 19.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveCar(_ car: Cars) {
        try! realm.write {
            realm.add(car)
        }
    }

    static func saveCarInfo(_ car: CarInfo) {
        try! realm.write {
            realm.add(car)
        }
    }

    static func deleteCar(_ car: Cars) {
        try! realm.write {
            realm.delete(car)
        }
    }

    static func deleteAllCars() {
        try! realm.write {
            realm.deleteAll()
        }
    }


    static func importCatalog() -> Realm {
        let config = Realm.Configuration(
        fileURL: Bundle.main.url(forResource: "CarsCatalogInfo", withExtension: "realm"),
        readOnly: true)
        let realm = try! Realm(configuration: config)
        return realm
    }

}
