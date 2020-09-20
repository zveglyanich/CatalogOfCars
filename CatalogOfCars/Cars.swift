//
//  CarsList.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 19.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import RealmSwift

class Cars: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var brand: String? = ""
    @objc dynamic var model: String? = ""
    @objc dynamic var body: String? = ""
    @objc dynamic var year: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
