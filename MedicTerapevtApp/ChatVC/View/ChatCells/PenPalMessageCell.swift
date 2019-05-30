//
//  PenPalMessageCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 21/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class PenPalMessageCell: UITableViewCell {
    

    @IBOutlet weak var labText: MessageLabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var imPatient: UIImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        imPatient.layer.cornerRadius = imPatient.bounds.height / 2
        imPatient.clipsToBounds = true
    }

}
