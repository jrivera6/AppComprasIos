//
//  ProductosCollection.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire

class ProductosCollection: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var factura: String!
    var detalleFacturas: [DetalleFactura] = []
    var productos: [ProductoModel] = []
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        getDetalles()
        
        self.reloadData()
    }
    
    
    func getDetalles(){
        
        let url = "https://api2-marco121942.c9users.io/factura/detalle"
        factura = UserDefaults.standard.string(forKey: "factura_id")
        
        
        
        let params: Parameters = ["id_factura": factura!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[DetalleFactura]>) in
            
            if response.result.isSuccess{
                
                print("detalle facturas \(response.result.value!)")
                self.detalleFacturas = response.result.value!
                self.getProductos()
            }
            
        }
        
    }
    
    func getProductos() {
        let url = "\(Constant.API_BASE_URL)/producto/idProducto"
        print("llego aqui \(detalleFacturas)")
        
        for f in self.detalleFacturas {
            print("llego fro \(detalleFacturas)")
            let params: Parameters = ["id_producto": f.id_producto!]
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[ProductoModel]>) in
            
                print("llego aqui")
                if response.result.isSuccess{
                    self.productos = response.result.value!
                    
                    print("ollection \(self.productos)")
                    self.reloadData()
                }
                
            }
        }
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductosCell", for: indexPath) as! ProductosCell
        
        let producto = productos[indexPath.row]
        
        cell.setUltimosProductos(producto: producto)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
        
    }
    
}
