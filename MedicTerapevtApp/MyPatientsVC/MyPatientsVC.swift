//
//  MyPatientsVC.swift
//  MedicTerapevtApp
//
//  Created by Ацамаз Бицоев on 30/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class MyPatientsVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()

    }
    
    
    private func setTabBar() {
        
        let myPatientsImage = UIImage(named: "Чат иконка")!
        self.tabBarItem = UITabBarItem(title: "Мои пациенты", image: myPatientsImage, selectedImage: myPatientsImage)
        self.tabBarController?.selectedIndex = 0
    }

}
