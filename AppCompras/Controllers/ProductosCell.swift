//
//  ProductosCell.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class ProductosCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var txtProducto: UILabel!
    
    func setUltimosProductos(producto: UltimosProductos){
        
        imgProducto.sd_setImage(with: URL(string: producto.imagen)!, placeholderImage: UIImage(named: "thumbnailUrl"))
        
        txtProducto.text = producto.nombre
        
    }
    
    
}
