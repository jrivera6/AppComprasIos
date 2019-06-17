//
//  Menu.swift
//  Tecsup
//
//  Created by user129308 on 7/28/17.
//
//

class Menu{

    var icon:String
    
    var name:String
    
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html
    init(withIcon icon: String, withName name: String) {
        self.icon = icon
        self.name = name
    }
    
}
