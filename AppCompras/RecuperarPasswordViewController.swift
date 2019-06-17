//
//  RecuperarPasswordViewController.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 5/29/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class RecuperarPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        customNavigationBar()
        
        
        
    }
    
    func customNavigationBar(){
//
//        let leftButton = UIButton(type: .system)
//        leftButton.setImage(UIImage(named: "backbutton"), for: .normal)
//
//        leftButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    
//        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        
    }

    


    @IBAction func backTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
            return .lightContent
    }
    
   
}
