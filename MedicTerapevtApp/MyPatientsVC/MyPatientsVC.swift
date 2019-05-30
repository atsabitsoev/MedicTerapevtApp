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
    
    override func viewWillLayoutSubviews() {
        setNavigationBar()
    }
    
    
    private func setTabBar() {
        
        let myPatientsImage = UIImage(named: "Чат иконка")!
        self.tabBarItem = UITabBarItem(title: "Мои пациенты", image: myPatientsImage, selectedImage: myPatientsImage)
        self.tabBarController?.selectedIndex = 0
    }
    
    private func setNavigationBar() {
        
        let colors = [Colors().greenGradient1,
                           Colors().greenGradient2]
        
        self.tabBarController!.navigationController!.navigationBar.setGradientBackground(colors: colors, startPoint: .bottomLeft, endPoint: .topRight)
        let item = UINavigationItem(title: "Мои пациенты")
        self.tabBarController?.navigationController?.navigationBar.setItems([item], animated: true)
        
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage!
    }

}
