//
//  MyPatientsCell.swift
//  MedicTerapevtApp
//
//  Created by Ацамаз Бицоев on 30/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class MyPatientsCell: UITableViewCell {
    
    
    @IBOutlet weak var imagePatient: UIImageView!
    

    override func layoutSubviews() {
        
        imagePatient.layer.cornerRadius = imagePatient.bounds.height / 2
    }

}
