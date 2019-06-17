//
//  AlertService.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/15/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert() -> CulqiAlertViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "CulqiVC") as! CulqiAlertViewController
        
        return alertVC
        
    }
    
}
