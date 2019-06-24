//
//  FacturaTableView.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire

class FacturaTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var facturas: [Factura] = []
    var usuario_id: String!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFacturas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFacturas()
    }
    
    
    func getFacturas(){
        
        let url = "\(Constant.API_BASE_URL)/factura/facturas"
        
        usuario_id = UserDefaults.standard.string(forKey: "user_id")
        
        print("Factura \(usuario_id!)")
        
        let params: Parameters = ["usuario_id":usuario_id!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[Factura]>) in
        
            if response.result.isSuccess{
                if response.response?.statusCode == 200{
                    self.facturas = response.result.value!
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "facturaSegue"{
            let siguienteVC = segue.destination as! FacturaAlertViewController
            siguienteVC.factura = sender as! Factura
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let factura = facturas[indexPath.row]
        
//        print("facturaaa \(factura)")
        
        performSegue(withIdentifier: "facturaSegue", sender: factura)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.facturas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "FacturaCell") as! FacturaCell
        
            let factura = facturas[indexPath.row]
        
            cell.setFactura(factura: factura)
//            let producto = productos[indexPath.row]
//            //            cell.nombreProducto.text = "prueba"
//            //            print("jhonny \(producto) ")
//            cell.setProducto(producto: producto)
            return cell
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return CGFloat(100)
//        }

}
