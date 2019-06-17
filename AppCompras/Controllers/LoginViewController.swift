//
//  LoginViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 5/28/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire
import SlideMenuControllerSwift


class LoginViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Principal") as! UITabBarController
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults.standard.set(true, forKey: "isLogged")
//        if UserDefaults.standard.bool(forKey: "isLogged") == true {
//
//            let pantallaPrincipal = self.storyboard?.instantiateViewController(withIdentifier: "Principal") as! UITabBarController
//
//            self.navigationController?.pushViewController(pantallaPrincipal, animated: false)
//
//        }
    }
    

    func goToMain() {
        
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
        
        
        
        mainViewController.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        
        //        mainViewController.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(changeTabWhenBack(_:)) )
        
        leftViewController.mainViewController = mainViewController
        
        
        //Settings NavigationController options
        let navController = UINavigationController(rootViewController: mainViewController)
        navController.navigationBar.barTintColor = UIColor(red:1.00, green:0.36, blue:0.18, alpha:1.0)
        navController.navigationBar.tintColor = .white
        navController.navigationBar.barStyle = .black
        
        
        
        let slideMenuController = SlideMenuController(mainViewController: navController, leftMenuViewController: leftViewController)
        
        let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        
        navigationController.viewControllers = [slideMenuController]
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //Test Almofire
    
    
    
    
//    @objc func openCamera(_ sender: UIBarButtonItem){
//
//        print("Abrir camara despues del login")
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let EscanerQr = storyboard.instantiateViewController(withIdentifier: "Escaner") as! QRViewController
//
//
//
//
//        mainViewController.navigationController?.pushViewController(EscanerQr, animated: true)
//        mainViewController.selectedIndex = 1
//    }
    
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        
        if txtUsuario.text!.isEmpty || txtPassword.text!.isEmpty{

            let alertError = UIAlertController(title: "Error", message: "Falta ingresar Email o Contraseña", preferredStyle: .alert)
            
            let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
            
            alertError.addAction(cerrarAction)
            
            present(alertError, animated: true, completion: nil)
            
            return
        }

        let url = "\(Constant.API_BASE_URL)/usuario/login"
        
        

        let parametros: Parameters = ["correo": txtUsuario.text!, "password": txtPassword.text! ]
        
//        Alamofire.request(url, method: .post, parameters: parametros, encoding: URLEncoding.default).responseJSON{response in
//            print(response.result.value!)
//        }

        Alamofire.request(url, method: .post, parameters: parametros, encoding: URLEncoding.default).responseObject{(response: DataResponse<User>) in

            if response.result.isSuccess{
                print(response.result.value!)

                if response.response?.statusCode == 200{
                    self.user = response.result.value!
                    
                    print("id usuario en el login \(self.user!.id_usuario!)")
                    
                    UserDefaults.standard.set(String(self.user!.id_usuario! as! Int), forKey: "user_id")
                    UserDefaults.standard.set(self.user!.nombre, forKey: "nombre_user")
                    UserDefaults.standard.set(self.user!.apellido!, forKey: "apellido_user")
                    UserDefaults.standard.set(self.user!.correo!, forKey: "correo_user")
                    UserDefaults.standard.set(self.user!.telefono!, forKey: "telefono_user")
                    UserDefaults.standard.set(true, forKey: "isLogged")
                    
                    
                    self.goToMain()
                }else{
                    let alertError = UIAlertController(title: "Error", message: "Email o Contraseña no existen", preferredStyle: .alert)
                    
                    let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
                    
                    alertError.addAction(cerrarAction)
                    
                    self.present(alertError, animated: true, completion: nil)
                }
                

                
            }else{
                let alertError = UIAlertController(title: "Error", message: "Email o Contraseña no existen", preferredStyle: .alert)
                
                let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
                
                alertError.addAction(cerrarAction)
                
                self.present(alertError, animated: true, completion: nil)
                
                
                
            }

        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}

