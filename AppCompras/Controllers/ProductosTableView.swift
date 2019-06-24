//
//  ProductosTableView.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire

class ProductosTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var productos: [ProductoArray] = []
    
    override func awakeFromNib() {
        
        print("Iniciando table \(productos) ")
        
        getAllProducts()
        
        
        self.delegate = self
        self.dataSource = self
        self.reloadData()
//    let url = "\(Constant.API_BASE_URL)/usuario/login"
//        print(" ruta \(url)")
    }
    
    
    
    func getAllProducts(){
        
        let url = "\(Constant.API_BASE_URL)/producto/listar"
        
        Alamofire.request(url).responseArray{(response: DataResponse<[ProductoArray]>) in
            self.productos = response.result.value!
            self.reloadData()
//            print(response.result.value!)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else{
            return productos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let row = indexPath.section
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UltimaCompraCell") as! UltimaCompraCell
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromocionesCell") as! PromocionesCell
            
            let producto = productos[indexPath.row]
//            cell.nombreProducto.text = "prueba"
//            print("jhonny \(producto) ")
            cell.setProducto(producto: producto)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        if section == 0 {
            view.backgroundColor = UIColor(red:1.00, green:0.40, blue:0.15, alpha:1.0)
            label.text = "Tus Ultimas Compras"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.frame = CGRect(x: 6, y: 5, width: 200, height: 25)
            view.addSubview(label)
            return view
        }else{
            view.backgroundColor = UIColor(red:1.00, green:0.40, blue:0.15, alpha:1.0)
            label.text = "Promociones"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.frame = CGRect(x: 6, y: 5, width: 200, height: 25)
            view.addSubview(label)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let factura = UserDefaults.standard.string(forKey: "factura_id")
        
        if indexPath.section == 0 {
            if factura == nil{
                return CGFloat(0)
            }else{
                return CGFloat(110)
            }
            
        }else{
            return CGFloat(100)
        }
        
        
        
    }

}
