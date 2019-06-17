//
//  FacturaAlertViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class FacturaAlertViewController: UIViewController {

    var factura: Factura? = nil
    
    @IBOutlet weak var txtCodigoFactura: UILabel!
    @IBOutlet weak var txtFecha: UILabel!
    
    @IBOutlet weak var txtTotalApagar: UILabel!
    
    @IBOutlet weak var txtTarjeta: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("objeto \(factura!)")
        setData()
    }
    
    func setData(){
        txtCodigoFactura.text = "Nº Factura \(factura!.codigo_factura!)"
        txtFecha.text = factura!.fecha_pago!
        
        txtTotalApagar.text = "Total: \(factura!.total_pago!)"
        
        txtTarjeta.text = factura!.marca_tarjeta!
        
    }
    
    @IBAction func btn_cerrar(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
//    func openAlert(){
//
//        let alert = AlertFacturaService()
//
//        let alertVC = alert.alert()
//
////        self.present
//
//    }
}
