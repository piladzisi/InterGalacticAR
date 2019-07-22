//
//  PlanetCellTableViewCell.swift
//  InterGalacticAR
//
//  Created by anna.sibirtseva on 22/07/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var planetImage: UIImageView!
    
    @IBOutlet weak var planetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        planetImage.layer.cornerRadius = 10
    }
    func configureCell(planet: String){
        planetLabel.text = planet.capitalized
        planetImage.image =  UIImage(named: planet)
    }
}
