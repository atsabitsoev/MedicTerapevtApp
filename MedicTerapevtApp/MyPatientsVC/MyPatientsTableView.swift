
//
//  MyPatientsTableView.swift
//  MedicTerapevtApp
//
//  Created by Ацамаз Бицоев on 30/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension MyPatientsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPatientsCell") as! MyPatientsCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chatVC = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        
        let cell = tableView.cellForRow(at: indexPath) as! MyPatientsCell
        chatVC.currentPatientName = cell.labName.text
        
        self.tabBarController?.navigationController?.show(chatVC, sender: nil)
    }
    
    
}
