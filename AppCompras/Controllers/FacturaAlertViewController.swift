//
//  FacturaAlertViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire

class FacturaAlertViewController: UIViewController {

    var factura: Factura? = nil
    var detalleFactura: [DetalleFactura] = []
    var productos: [ProductoModel] = []
    var precioUnitario: Double? = nil
    var cantidad: Double? = nil
    var positionY = 343
    
    @IBOutlet weak var txtCodigoFactura: UILabel!
    @IBOutlet weak var txtFecha: UILabel!
    
    @IBOutlet weak var txtTotalApagar: UILabel!
    
    @IBOutlet weak var txtTarjeta: UILabel!
    @IBOutlet weak var txtNombreUsuario: UILabel!

    @IBOutlet weak var txtCorreUsuario: UILabel!
    @IBOutlet weak var txtTelefonoUsuario: UILabel!
    
    var lblCantidad = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    var lblProducto = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
    var lblPrecioUnitario = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    var lblImporte = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("objeto \(factura!)")
        setData()
        
        
        
    }
    
    func settingsLabel(y: Int){
        lblCantidad.center = CGPoint(x: 75, y: y)
        lblCantidad.font = lblCantidad.font.withSize(9)
        lblCantidad.textAlignment = .center
        self.view.addSubview(lblCantidad)
        
        lblProducto.center = CGPoint(x: 170, y: y)
        lblProducto.font = lblProducto.font.withSize(9)
        lblProducto.numberOfLines = 4
        lblProducto.textAlignment = .left
        self.view.addSubview(lblProducto)
        
        lblPrecioUnitario.center = CGPoint(x: 353, y: y)
        lblPrecioUnitario.font = lblPrecioUnitario.font.withSize(9)
        lblPrecioUnitario.numberOfLines = 2
        lblPrecioUnitario.textAlignment = .left
        self.view.addSubview(lblPrecioUnitario)
        
        
        lblImporte.center = CGPoint(x: 390, y: y)
        lblImporte.font = lblImporte.font.withSize(9)
        lblImporte.numberOfLines = 2
        lblImporte.textAlignment = .left
        self.view.addSubview(lblImporte)
    }
    
    func setData(){
        
        let nombreUsuario = UserDefaults.standard.string(forKey: "nombre_user")
        let apellidoUsuario = UserDefaults.standard.string(forKey: "apellido_user")
        let correoUsuario = UserDefaults.standard.string(forKey: "correo_user")
        let telefonoUsuario = UserDefaults.standard.string(forKey: "telefono_user")
        
        //Set values
        txtCodigoFactura.numberOfLines = 2
        txtCodigoFactura.text = "Nº Factura\n\(factura!.codigo_factura!)"
        txtFecha.text = "Fecha de emisiòn\n\(factura!.fecha_pago!)/06/2019"
        
        txtTotalApagar.text = "Total: S/. \(factura!.total_pago!)"
        
        txtTarjeta.text = "TARJETA: \(factura!.marca_tarjeta!)"
        
        txtNombreUsuario.text = "RECEPTOR: \(nombreUsuario!) \(apellidoUsuario!)"
        txtCorreUsuario.text = "E-MAIL: \(correoUsuario!)"
        txtTelefonoUsuario.text = "TELEFONO: \(telefonoUsuario!)"
        
        
        let url = "https://api2-marco121942.c9users.io/detalleFactura/detalleFactura"
        
        print("factura actual: \(String(describing: factura!.id_factura!))")
        let params: Parameters = ["id_factura": factura!.id_factura!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[DetalleFactura]>) in
            
            if response.result.isSuccess{
                
                self.detalleFactura = response.result.value!
                for df in self.detalleFactura{
                    self.lblCantidad.text = df.cantidad
                    
                    self.cantidad = Double(df.cantidad!)
                }
                
                self.getProductos()
            }
            
        }
        
        
    }
    
   
    
    @IBAction func btn_cerrar(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func getProductos() {
        let url = "\(Constant.API_BASE_URL)/producto/idProducto"
//        print("llego aqui \(detalleFactura)")
        
        for f in self.detalleFactura {
//            print("llego fro \(detalleFactura)")
            
            print("detalle \(f.id_detalle)")
            
            let params: Parameters = ["id_producto": f.id_producto!]
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[ProductoModel]>) in
                
                print("llego aqui")
                if response.result.isSuccess{
                    
                    
                    self.productos = response.result.value!
                    
                    
                    
                    for p in self.productos{
                        print("para la factura \(p)")
                        
                        self.settingsLabel(y: self.positionY)
                        self.lblProducto.text = "\(p.nombre_producto!):\n\(p.descripcion!)"
                        
                        self.lblPrecioUnitario.text = "S/. \(String(p.precio as! Double))"
                        
                        self.precioUnitario = Double(truncating: p.precio!)
                        self.positionY += 10
                        
                    }
                    self.importe()
                    
                    
//                    print("ollection \(self.ultimosProductos)")
//                    self.reloadData()
                }
                
            }
        }
        
    }
    
    func importe(){
        
        let importe = self.precioUnitario! * self.cantidad!
        print("el importe: \(importe)")
        self.lblImporte.text = " S/. \(String(importe))"
        
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
