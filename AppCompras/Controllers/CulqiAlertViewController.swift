//
//  CulqiAlertViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/15/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire

class CulqiAlertViewController: UIViewController {
    
    var factura: Factura!
    var productosCarrito: [Producto] = []
    var tableView: UITableView?
    var user_id: String!
    
    var carrito: [Producto] = []
    
    
    
    
    @IBOutlet weak var btnPagar: UIButton!
    
    @IBOutlet weak var txtNumeroTarjeta: CustomTextField!
    
    @IBOutlet weak var txtVencimiento: CustomTextField!
    
    
    @IBOutlet weak var txtCVV: CustomTextField!
    
    @IBOutlet weak var txtCorreo: CustomTextField!
    
    var pagoTotal: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carrito = productosCarrito
    
        print("carrito \(carrito)")
        
        settingButton(pagoTotal: pagoTotal!)
        
    }
    
    func settingButton(pagoTotal: String){
        btnPagar.setTitle("Pagar S/ \(pagoTotal) PEN", for: UIControlState.normal)
    }
    
    func saveDetalleFactura(){
        
        
        let url = "\(Constant.API_BASE_URL)/detalleFactura/crear"
        
        print("en el fire \(productosCarrito)")
        
        for p in productosCarrito{
            print("en el \(p.id_producto)")
            
            UserDefaults.standard.set(self.factura!.id_factura!, forKey: "factura_id")
            
            let params: Parameters = [
                "id_factura": String(self.factura?.id_factura! as! Int),
                "id_producto": String(p.id_producto),
                "cantidad": "1",
                "estado": "vacio",
                "precio_unitario": String(p.precio! as! Double),
                "subtotal": String(p.precio! as! Double * 1)
                
            ]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseObject{ (response: DataResponse<DetalleFactura>) in
                
                if response.result.isSuccess {
                    
                    if response.response?.statusCode == 200{
                        
                        
                        for p in self.productosCarrito{
                            
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            context.delete(p)
                            (UIApplication.shared.delegate as! AppDelegate).saveContext()
                            
                        }
                        
                        self.tableView?.reloadData()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
    }
    
    func saveFactura(){
        //Fecha actual
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        let fecha_actual = formater.string(from: date)
        print(fecha_actual)
        
        
        //Id de usuario
        user_id = UserDefaults.standard.string(forKey: "user_id")
        
        //TipoPago
        let tipo_factura = "Virtual"
        
        //Codigo de la factura
        let codigo_factura = "FC-\(date)_\(Int.random(in: 0..<20))"
        
        //Tipo de tarjeta
        let tipo_tarjeta = "Debito"
        
        //Marca de la tarjeta
        let marca_tarjeta = "BCP"
        
        let url = "\(Constant.API_BASE_URL)/factura/crear"
        
        print("id usuario \(String(describing: user_id!))")
        
        let params: Parameters = [
            "fecha_pago": fecha_actual,
            "total_pago": self.pagoTotal!,
            "usuario_id": user_id!,
            "tipo_factura": tipo_factura,
            "estado": "Exitoso",
            "codigo_factura": codigo_factura,
            "tipo_tarjeta": tipo_tarjeta,
            "marca_tarjeta": marca_tarjeta
            
        ]
        
        
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseObject{(response: DataResponse<Factura>) in
            
            if response.result.isSuccess{
                
                
                
                if response.response?.statusCode == 200{
                    self.factura = response.result.value!
                    self.saveDetalleFactura()
                    
                    
                }else{
                    print(response.result.error!)
                }
                
            }else{
                print(response.result.error!)
            }
            
        }
    }
    
    @IBAction func btnRealizarPago(_ sender: Any) {
        
//        if txtNumeroTarjeta.text!.isEmpty || txtVencimiento.text!.isEmpty || txtCVV.text!.isEmpty || txtCorreo.text!.isEmpty{
//            let alertError = UIAlertController(title: "Error", message: "Falta ingresar datos para la compra", preferredStyle: .alert)
//
//            let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
//
//            alertError.addAction(cerrarAction)
//
//            present(alertError, animated: true, completion: nil)
//
//            return
//        }
        
        saveFactura()
        
        
        self.tableView?.reloadData()
        dismiss(animated: true, completion: nil
        )
        
//        let pagoRealizado: Bool = true
//        //importar culqi para realizar pago
//
//        //eliminar todos los datos
//
//        if pagoRealizado == true{
//
//
//            for p in productosCarrito{
//
//                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//                context.delete(p)
//                (UIApplication.shared.delegate as! AppDelegate).saveContext()
//
//            }
        
        
//        let alertError = UIAlertController(title: "Aviso", message: "Compra realizo exitosamente", preferredStyle: .alert)
//
//        let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive){ (action:UIAlertAction) in
//            self.tableView?.reloadData()
//
//        }
//
//        alertError.addAction(cerrarAction)
//
//        present(alertError, animated: true, completion: nil)
        
//
//
//        }
//
//        print("en el carrito \(carrito)")
        
        
        
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let alertError = UIAlertController(title: "Aviso", message: "Compra realizo exitosamente", preferredStyle: .alert)
//
//        let cerrarAction = UIAlertAction(title: "Cerrar", style: .cancel){ (action:UIAlertAction) in
//            tableView?.reloadData()
//
//        }
//
//        alertError.addAction(cerrarAction)
//
//        present(alertError, animated: true, completion: nil)
//    }
    
    @IBAction func btnCerrar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
