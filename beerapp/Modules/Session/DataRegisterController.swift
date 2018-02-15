//
//  DataRegisterViewController.swift
//  beerapp
//
//  Created by elaniin on 1/24/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Alamofire
import AccountKit

class DataRegisterController: UIViewController {

    // MARK: - Let/Var
    let constantsMessages = Constants()
    let constantsTitles = Titles()
    var isHighLighted:Bool = false
    var gender = String()
    var birthday = String()
    var userName = String()
    var accountKit: AKFAccountKit!
    
    
    // MARK: - Outlets
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var myTeamtextField: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var replypasswordTextfield: UITextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
        
        
    }
    
    
    // MARK: - Actions
    
    //Register validations and check
    @IBAction func registerAction(_ sender: Any) {
        
        
        if self.birthdayTextField.text?.isEmpty ?? true || (self.birthdayTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

            Core.alert(message: constantsMessages.birthdayempty, title: constantsTitles.empty, at: self)

        }else if self.usernameTextfield.text?.isEmpty ?? true || (self.usernameTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

            Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty, at: self)

        }else if self.passwordTextfield.text?.isEmpty ?? true || (self.passwordTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

            Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)

        }else if self.replypasswordTextfield.text?.isEmpty ?? true || (self.replypasswordTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

            Core.alert(message: constantsMessages.replypassword, title: constantsTitles.empty, at: self)
            
        }else if self.replypasswordTextfield.text != self.passwordTextfield.text{
            
            Core.alert(message: constantsMessages.samepassword, title: constantsTitles.password, at: self)

        }else{
            
            self.accountKit.logOut()
            openUpRegister()


        }

    }
    
    //SelectBirthday,action to set a date
    @IBAction func selectBirhtday(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    
    //--- Actions with gender
    
    @IBAction func genderFemaleAction(_ sender: UIButton) {
        
            SwiftyBeaver.warning("empty gender")
            SwiftyBeaver.debug("works")
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#009D9A")
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#1C2742")
            
        
        
    }
    
    @IBAction func genderMaleAction(_ sender: Any) {
        
            SwiftyBeaver.warning("empty gender")
            SwiftyBeaver.debug("works")
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#009D9A")
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#1C2742")
        
            
        
    }
    //--
    
    
    //Back to main function
    
    @IBAction func backtoMain(_ sender: Any) {
        accountKit.logOut()
        
        
         let _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    // MARK: - Helpers/Initializers/Setups

    
    
    //General setup
    func SetUp(){
        
        // initialize Account Kit
        if accountKit == nil {
            // may also specify AKFResponseTypeAccessToken
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
        
        //itembar
        Core.itembarbackground(controller: self, barTint: Core.hexStringToUIColor(hex: "#213363"), titleColor: Core.hexStringToUIColor(hex: "#59BCCA"))
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        
        //Check Gender
        if(self.gender == "male" && self.gender.isEmpty == false){
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#009D9A")
            self.manButton.isEnabled         = false
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#1C2742")
            
            
        }else if (self.gender == "female" && self.gender.isEmpty == false ){
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#009D9A")
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#1C2742")
            
        }
        
        
        //Check birthday
        if self.birthday != "" {
            self.birthdayTextField.text = self.birthday
            
        }
        
        
    }
    
    //Set te values changes
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        3
        self.birthdayTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
    //Open our Slider after registratation processs
    func openUpRegister(){
        let storyboard = UIStoryboard(name: "App", bundle: nil)
        let openWalkthrough = storyboard.instantiateViewController(withIdentifier: "TourControllerID") as! TourController
        present(openWalkthrough, animated: true, completion: nil)
    }
    
    

}
