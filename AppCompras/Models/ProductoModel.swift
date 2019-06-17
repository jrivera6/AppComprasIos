//
//  Producto.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/7/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import EVReflection

class ProductoModel:EVNetworkingObject {
    
    public var id_producto: NSNumber?
    public var nombre_producto: String?
    public var precio: NSDecimalNumber?
    public var stock: NSNumber?
    public var imagen: String?
    public var descripcion: String?
    public var categoria_id: NSNumber?
    public var codigo: String?
    
}
