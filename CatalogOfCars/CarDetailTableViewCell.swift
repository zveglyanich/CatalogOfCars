//
//  CarDetailTableViewCell.swift
//  CatalogOfCars
//
//  Created by Павел Звеглянич on 20.09.2020.
//  Copyright © 2020 Pavel Zveglyanich. All rights reserved.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var carCharacterLabel: UILabel!
    
    @IBOutlet weak var carValueCharacterTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
