//
//  Factura.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import EVReflection

class Factura: EVNetworkingObject{
    
    public var id: NSNumber?
    public var fecha_pago: String?
    public var total_pago: String?
    public var usuario_id: String?
    public var tipo_factura: String?
    public var codigo_factura: String?
    public var tipo_tarjeta: String?
    public var marca_tarjeta: String?
    
}
