//
//  DetalleFactura.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import EVReflection

class DetalleFactura: EVNetworkingObject{
    
    public var id: NSNumber?
    public var id_factura: String?
    public var id_producto: String?
    public var cantidad: String?
    public var estado: String?
    public var precio_unitario: String?
    public var subtotal: String?
    
}
