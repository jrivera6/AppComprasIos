//
//  MenuViewController.swift
//  Tecsup
//
//  Created by user129308 on 7/28/17.
//
//

import UIKit
import SDWebImage

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var fullname: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainViewController: UITabBarController!
    
    var options = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get User Info
//        let user:UserMO = UserDAO.get()!
        
        let firstname = UserDefaults.standard.string(forKey: "nombre_user")
        let lastname = UserDefaults.standard.string(forKey: "apellido_user")
        
        self.fullname.text = "\(firstname!) \(lastname!)"

        self.email.text = UserDefaults.standard.string(forKey: "correo_user")
        
//        if user.picture != nil {
//            self.picture.sd_setImage(with: URL(string: user.picture!), placeholderImage: UIImage(named: "ic_profile"))
//
//            self.picture.layer.borderWidth = 1
//            self.picture.layer.masksToBounds = false
//            self.picture.layer.borderColor = UIColor.black.cgColor
//            self.picture.layer.cornerRadius = self.picture.frame.height/2
//            self.picture.clipsToBounds = true
//        }
        
        self.options.append(Menu(withIcon: "ic_camera", withName: "Escanear Producto"))
        self.options.append(Menu(withIcon: "ic_list", withName: "Promociones"))
        self.options.append(Menu(withIcon: "ic_cart", withName: "Carrito"))
        self.options.append(Menu(withIcon: "ic_history", withName: "Historia"))
//        self.options.append(Menu(withIcon: "ic_payment", withName: "Pagos"))
//        self.options.append(Menu(withIcon: "ic_history", withName: "Historial"))
//        self.options.append(Menu(withIcon: "ic_news", withName: "Noticias"))
//        self.options.append(Menu(withIcon: "ic_alerts", withName: "Alertas"))
//        //self.options.append(Menu(withIcon: "ic_settings", withName: "Configuración"))
        self.options.append(Menu(withIcon: "ic_exit", withName: "Salir"))
        
        // Top Margin for tableView
        self.tableView.contentInset = UIEdgeInsetsMake(16, 0, 0, 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menu:Menu = options[indexPath.row]
        
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"Cell")
        cell.textLabel?.text = menu.name
        cell.imageView?.image = UIImage(named: menu.icon)
        cell.imageView?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menu:Menu = options[indexPath.row]
        
        switch menu.icon {
        case "ic_camera":
            print("goHome()")
            let EscanerQr = self.storyboard?.instantiateViewController(withIdentifier: "Escaner") as! QRViewController
            mainViewController.navigationController?.pushViewController(EscanerQr, animated: true)
            mainViewController.selectedIndex = 1
        case "ic_list":
            print("prueba")
            mainViewController.selectedIndex = 0
        case "ic_cart":
            print("goCalendar()")
            mainViewController.selectedIndex = 1
        case "ic_history":
            print("goScores()")
            mainViewController.selectedIndex = 2
        case "ic_exit":
            goShutdown()
        default:
            print("Not implemented")
        }
        
        self.slideMenuController()?.closeLeft()
        
    }
    
    func goShutdown(){
        
        print("salio")
        
        
        
        let alertCerrarSesion = UIAlertController(title: "Cerrar Sesión", message: "¿Esta seguro de cerrar sesión?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .destructive){ (action:UIAlertAction) in
        }
        
        let aceptarAction = UIAlertAction(title: "Si", style: .cancel){ (action:UIAlertAction) in
            UserDefaults.standard.set(false, forKey: "isLogged")
            exit(0)
        }
        
        alertCerrarSesion.addAction(aceptarAction)
        alertCerrarSesion.addAction(cancelAction)
        
        self.present(alertCerrarSesion, animated: true, completion: nil)
        
        
//        // Save to user defaults (shared preferences)
//        let preferences = UserDefaults.standard
//        preferences.removeObject(forKey: Constant.PREF_ISLOGGED)
//        preferences.removeObject(forKey: Constant.PREF_TOKEN)
//        preferences.synchronize()
//
//        // exit
//        exit(0)
        
    }
    
}

