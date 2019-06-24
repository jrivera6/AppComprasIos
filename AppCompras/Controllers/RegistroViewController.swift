//
//  RegistroViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/17/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import Alamofire
import SlideMenuControllerSwift

class RegistroViewController: UIViewController {
    
    var user: User?
    
    var mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Principal") as! UITabBarController

    @IBOutlet weak var txtNombres: RegistroTextField!
    
    @IBOutlet weak var txtApellidos: RegistroTextField!
    
    @IBOutlet weak var txtCorreo: RegistroTextField!
    
    @IBOutlet weak var txtTelefono: RegistroTextField!
    
    @IBOutlet weak var txtPassword: RegistroTextField!
    
    @IBOutlet weak var txtConfirmPassword: RegistroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("registro")

//        let url = "https://api2-marco121942.c9users.io/usuario/crear"
//        let params: Parameters = [
//            "nombre": "prueba1",
//            "apellido": "prueba1",
//            "correo": "prueba2@prueba.com",
//            "telefono": "12341259",
//            "password": "123415"
//        ]
//
////        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{response in
////            print(response.result.value!)
////        }
//
//        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseObject{(response: DataResponse<User>) in
//
//            print("data \(response.result.value!)")
//        }
        
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func crearCuentaTapped(_ sender: Any) {
        
        if txtNombres.text!.isEmpty || txtApellidos.text!.isEmpty || txtCorreo.text!.isEmpty || txtTelefono.text!.isEmpty || txtPassword.text!.isEmpty || txtConfirmPassword.text!.isEmpty {
            
            let alertError = UIAlertController(title: "Error", message: "Es necesario llenar todos tus datos", preferredStyle: .alert)
            
            let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
            
            alertError.addAction(cerrarAction)
            
            present(alertError, animated: true, completion: nil)
            
        }else{
            if txtPassword.text! != txtConfirmPassword.text!{
                let alertError = UIAlertController(title: "Error", message: "Las contraseñas no coinciden", preferredStyle: .alert)
                
                let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
                
                alertError.addAction(cerrarAction)
                
                present(alertError, animated: true, completion: nil)
            }else{
                
                let url = "\(Constant.API_BASE_URL)/usuario/crear"
                let params: Parameters = [
                    "nombre": txtNombres.text!,
                    "apellido": txtApellidos.text!,
                    "correo": txtCorreo.text!,
                    "telefono": txtTelefono.text!,
                    "password": txtPassword.text!
                ]
                
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseObject{(response: DataResponse<User>) in
                    
                    
                    if response.result.isSuccess{
                        
                        if response.response?.statusCode == 200{
                            self.user = response.result.value!
                            
                            UserDefaults.standard.set(self.user!.id_usuario! as! Int, forKey: "user_id")
                            UserDefaults.standard.set(self.user!.nombre, forKey: "nombre_user")
                            UserDefaults.standard.set(self.user!.apellido!, forKey: "apellido_user")
                            UserDefaults.standard.set(self.user!.correo!, forKey: "correo_user")
                            UserDefaults.standard.set(self.user!.telefono!, forKey: "telefono_user")
                            UserDefaults.standard.set(true, forKey: "isLogged")
                            self.goToMain()
                            
                        }else{
                            let alertError = UIAlertController(title: "Error", message: "El correo o numero de teléfono ya está en uso", preferredStyle: .alert)
                            
                            let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
                            
                            alertError.addAction(cerrarAction)
                            
                            self.present(alertError, animated: true, completion: nil)
                        }
                        
                    } else {
                        
                        let alertError = UIAlertController(title: "Error", message: "El correo o numero de teléfono ya está en uso", preferredStyle: .alert)
                        
                        let cerrarAction = UIAlertAction(title: "Cerrar", style: .destructive)
                        
                        alertError.addAction(cerrarAction)
                        
                       self.present(alertError, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                    
                }
                
            }
        }
        
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
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
                dismiss(animated: true, completion: nil)
    }
}
