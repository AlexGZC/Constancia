//
//  PasswordRecoveryViewController.swift
//  beerapp
//
//  Created by elaniin on 1/19/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit

class PasswordRecoveryController: UIViewController {
    
    // MARK: - Let/Var
    
    // MARK: - Outlets
    
    @IBOutlet weak var recoverPasswordTextfield: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calling my general functions
        self.General()
        
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
    }
    
    // MARK: - Actions
    func General(){
        
        
    }
    
    // MARK: - Helpers/Initializers/Setups
    
}
