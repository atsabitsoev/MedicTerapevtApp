//
//  RoundedImage.swift
//  MedicTerapevtApp
//
//  Created by Ацамаз Бицоев on 30/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
}
