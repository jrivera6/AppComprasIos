//
//  FacturaCell.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class FacturaCell: UITableViewCell {

    
    @IBOutlet weak var txtNumeroFactura: UILabel!
    
    func setFactura(factura: Factura){
        
        txtNumeroFactura.text = "Factura Nº \(factura.codigo_factura!)"
        
    }
    
}
