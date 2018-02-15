//
//  BaseTabBarController.swift
//  beerapp
//
//  Created by elaniin on 1/29/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation
import AVKit

class BaseTabBarController: UITabBarController {
    
    let unselectedColor = Core.hexStringToUIColor(hex: "#31416E")
    
    @IBOutlet weak var mainTabBar: UITabBar!
    @IBInspectable var defaultIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = defaultIndex
        mainTabBar.unselectedItemTintColor = self.unselectedColor
        mainTabBar.tintColor = Core.hexStringToUIColor(hex: "#5EC1CD")
       //icon-tabbar-places
        mainTabBar.selectedItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: self.unselectedColor], for: .selected)
        
        
    
        
    }
   
    
}
