//
//  CarritoViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/4/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import Culqi
import SideMenuSwift


class CarritoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var productos: [Producto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("iniciando table view")
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
        
//        getProductosEnCarrito()
    

        
//        Culqi.setApiKey("sk_test_DJp4FQnpTigXd3XG")
//        
//        let culqi = Culqi.init()
   
//        culqi.createToken(withCardNumber: "4111111111111111", cvv: "123", expirationMonth: "09", expirationYear: "2020", email: "jhonny.rivera@tecsup.edu.pe", metadata: nil, success: ({(header,token) in print(token.identifier)}), failure: {(header,qlerror,err) in print("Header: \(header.environment) \(header.version) \(header.trackingIdentifier) error completo: \(err) Y Culqi error: \(qlerror.type) and \(qlerror.userMessage) \(qlerror.merchantMessage)" )})
        
        
        
    
        

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func getProductosEnCarrito(){
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        
        let context = delegate.persistentContainer.viewContext
        
        
        do{
            try productos = context.fetch(Producto.fetchRequest())
//            print(" linea 98 \(productos)")
            tableView.reloadData()
        }
        catch{
            
        }
    }
    
    func sumarTotal() -> String{
        
        var total: Double = 0
        
        for p in productos{
            
            if p.precio != nil {
                let p = p.precio as! Double
                total += p
            }else{
                total = 0.0
            }
            
            
        }
    
        return String(total)
    }
    
    
    
    @IBAction func btnComprar(_ sender: Any) {
        
        if Double(self.sumarTotal()) == 0.0 {
            
            
            let falloAlert = UIAlertController(title: "Error", message: "No hay ningun producto en la lista", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cerrar", style: .cancel){ (action:UIAlertAction) in
            }
            
            falloAlert.addAction(cancelAction)
            self.present(falloAlert, animated: true, completion: nil)
            return
            
        }
        
        let totalPagar = sumarTotal()
        
        let compraAlert = UIAlertController(title: "Confirmar Compra", message: "El total a pagar es S/ \(totalPagar)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive){ (action:UIAlertAction) in
            print("cancelar")
        }
        
        let alert = AlertService()
        
        let continuarAction = UIAlertAction(title: "Continuar", style: .default) { (action:UIAlertAction) in
            
            let alertVC = alert.alert()
            
            alertVC.pagoTotal = self.sumarTotal()
            alertVC.productosCarrito = self.productos
            alertVC.tableView = self.tableView
            
            self.present(alertVC, animated: true, completion: nil)
            
            
            
        }
        
    
        compraAlert.addAction(cancelAction)
        compraAlert.addAction(continuarAction)
        
        self.present(compraAlert, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let producto = productos[indexPath.row]
            let delegate = (UIApplication.shared.delegate as! AppDelegate)
            let context = delegate.persistentContainer.viewContext
            context.delete(producto)
            delegate.saveContext()
            viewWillAppear(true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.productos.count)
        return self.productos.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoTableViewCell") as! ProductoTableViewCell
        
        let producto = productos[indexPath.row]
        
        print("numero \(productos.count)")
        cell.tableView = self.tableView
        
        cell.setProducto(producto: producto)
        

//        cell.textLabel?.text = String(producto.categoria_id)
//        cell.textLabel?.text = String(producto.precio as! Double)
//        cell.imageView?.sd_setImage(with: URL(string: producto.imagen!)!, placeholderImage: UIImage(named: "thumbnailUrl"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
    
    
    @IBAction func cerrarSesion(_ sender: Any) {
        
//        UserDefaults.standard.set(false, forKey: "isLogged")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
//        tableView.reloadData()
        
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        
        let context = delegate.persistentContainer.viewContext
        
        
        do{
            try productos = context.fetch(Producto.fetchRequest())
//            print(" linea 98 \(productos)")
            tableView.reloadData()
        }
        catch{
            
        }
    }
    
    
}
