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
    var ultimosProductos = [UltimosProductos]()
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        getDetalles()
        
        self.reloadData()
        
        print("se abre la coleccion")
    }
    
    
    
    
    func getDetalles(){
        
        let url = "https://api2-marco121942.c9users.io/factura/detalle"
        factura = UserDefaults.standard.string(forKey: "factura_id")
        
        if factura == nil {
            self.ultimosProductos = []
        }else{
            let params: Parameters = ["id_factura": factura!]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[DetalleFactura]>) in
                
                if response.result.isSuccess{
                    
//                    print("detalle facturas \(response.result.value!)")
                    self.detalleFacturas = response.result.value!
                    self.getProductos()
                }
                
            }
        }
        
        
        
    }
    
    func getProductos() {
        let url = "\(Constant.API_BASE_URL)/producto/idProducto"
//        print("llego aqui \(detalleFacturas)")
        
        for f in self.detalleFacturas {
//            print("llego fro \(detalleFacturas)")
            let params: Parameters = ["id_producto": f.id_producto!]
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseArray{(response: DataResponse<[ProductoModel]>) in
            
//                print("llego aqui")
                if response.result.isSuccess{
                    
                    
                    self.productos = response.result.value!
                    
                    for up in self.productos{
                        self.ultimosProductos.append(UltimosProductos(withImagen: up.imagen!, withNombre: up.nombre_producto!))
                    }
                    
                    
                    
//                    print("ollection \(self.ultimosProductos)")
                    self.reloadData()
                }
                
            }
        }
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ultimosProductos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductosCell", for: indexPath) as! ProductosCell
        
        let producto = ultimosProductos[indexPath.row]
        
        cell.setUltimosProductos(producto: producto)
        
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
////        if(self.ulitmosProductos.count > 0){
////            print("cumple \(self.ulitmosProductos.count)")
////            return CGSize(width: 200, height: 200)
////        }else{
////            print("no cumple \(self.ulitmosProductos.count)")
////            return CGSize(width: 200, height: 0)
////        }
//
//        return CGSize(width: 0, height: 0)
//    }
    
}
