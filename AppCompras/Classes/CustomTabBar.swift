//
//  CustomTabBar.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 6/16/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import TabBarBox

class CustomTabBar: TabBarBoxController {

    override func viewDidLoad() {
        super.viewDidLoad()

        homeButton.addTarget(self, action: #selector(didTapAction(_:)), for: .touchUpInside)
    }
    

    @objc func didTapAction(_ sender: Any) {
        // do someThing
    }


}
