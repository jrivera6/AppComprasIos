//
//  PromocionesCell.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class PromocionesCell: UITableViewCell {

    @IBOutlet weak var imageProducto: UIImageView!
    
    @IBOutlet weak var nombreProducto: UILabel!
    
    @IBOutlet weak var precioNormalProducto: UILabel!

    
    @IBOutlet weak var precioPromocionProducto: UILabel!
    
    func setProducto(producto: ProductoArray){
        
        imageProducto.sd_setImage(with: URL(string: producto.imagen!)!, placeholderImage: UIImage(named: "thumbnailUrl"))
        
        nombreProducto.text = producto.nombre_producto
        
        precioNormalProducto.text = "S/ \(String(producto.precio as! Double))"
        
        precioPromocionProducto.text = "S/ \(String(producto.precio as! Double))"
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
