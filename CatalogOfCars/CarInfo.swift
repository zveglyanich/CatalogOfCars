//
//  CarInfo.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 20.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import RealmSwift

class CarInfo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var brand: String? = ""
    @objc dynamic var model: String? = ""

    override static func primaryKey() -> String? {
        return "id"
    }

}
