//
//  ProductoTableViewCell.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class ProductoTableViewCell: UITableViewCell {
    
    var tableView : UITableView?
    
    @IBOutlet weak var productoImageView: UIImageView!
    
    
    @IBOutlet weak var nombreProducto: UILabel!
    
    
    @IBOutlet weak var cantidadProducto: UILabel!
    
    @IBOutlet weak var precioProducto: UILabel!
    
    func setProducto(producto: Producto){
        
        print("producto \(String(describing: producto.nombre_producto))")
        
        
        if producto.imagen != nil{
            
            
            var cantidad: Int = 0
            
            if producto.codigo! == producto.codigo!{
                
                cantidad += 1
                productoImageView.sd_setImage(with: URL(string: producto.imagen!)!, placeholderImage: UIImage(named: "thumbnailUrl"))
                
                nombreProducto.text = producto.nombre_producto
                cantidadProducto.text = String(cantidad)
                precioProducto.text = "S/ \(String(producto.precio as! Double))"
            }else{
                cantidadProducto.text = "1"
            }
            
            
            
        }else{
            self.tableView?.reloadData()
        }
        
        
    }
    
}
