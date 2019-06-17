//
//  AlertFacturaService.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class AlertFacturaService {
    
    func alert() -> FacturaAlertViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "FacturaAlert") as! FacturaAlertViewController
        
        return alertVC
        
    }
    
}
