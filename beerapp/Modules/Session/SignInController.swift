//
//  SignInViewController.swift
//  App
//
//  Created by Jonathan Solorzano on 1/15/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import SwiftyBeaver
import AccountKit

class SignInController: UIViewController, AKFViewControllerDelegate{
    

    // MARK: - Let/Var
    private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]

    private let paramsGraph                       = ["fields": "id, name, first_name, last_name, email, gender, birthday"]

    var recoverPasswordString                     = "Olvidaste tu contraseña? Recuperala"

    var myMutableString                           = NSMutableAttributedString()

    var accountKit: AKFAccountKit!
    
    var saveFacebookDataArray = [FacebookUserData]()
    
    //Booleans to check facebook login states
    var checkLogin = Bool()
    var checkUserIsRegistered = true
    var registerState = Bool()
    var recoveryState = Bool()
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var passwordRecoverButton: UIButton!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        self.setUp()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (accountKit.currentAccessToken != nil && self.checkUserIsRegistered == false)  {
            // if the user is already logged in, go to the main screen
            
            DispatchQueue.main.async(execute: {
                for user in self.saveFacebookDataArray{
                    
                    let storyboard = UIStoryboard(name: "Session", bundle: nil)
                    let passtoSignUp = storyboard.instantiateViewController(withIdentifier: "DataRegisterViewControllerID") as! DataRegisterController
                
                
                    passtoSignUp.gender = (user.gender?.description)!
                    passtoSignUp.birthday = (user.birthday?.description)!
                   
                    
                    self.navigationController?.pushViewController(passtoSignUp, animated: true)
                }
                
            })
            
            
        }else if (accountKit.currentAccessToken != nil && self.recoveryState == true) {
            
            DispatchQueue.main.async(execute: {
                
                self.performSegue(withIdentifier: "recoverpassword", sender: self)
                
            })
        }else if (accountKit.currentAccessToken != nil && self.registerState == true) {
            // if the user is already logged in, go to the main screen
            SwiftyBeaver.debug("User is already logged")
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "showRegister", sender: self)
                
            })
            
            
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
    }
    
    // MARK: - Actions
    
    @IBAction func registerEmail(_ sender: Any) {
        self.registerState = true
        //login with Phone
        let inputState: String = UUID().uuidString
        let viewController: AKFViewController = accountKit.viewControllerForEmailLogin(withEmail: nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
    
    //Login with facebook request
    @IBAction func loginFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: readPermissions, viewController: self, completion: didReceiveFacebookLoginResult)
    }
    
    //Recoverpassword account kit request
    
    @IBAction func recoverPassword(_ sender: Any) {
        self.recoveryState = true
        self.callaAccountKit()
        
        
    }
    

    
    // MARK: - Helpers/Initializers/Setups
    
    func setUp(){
        //Background
        Core.shared.setbackground(image: "signup-background",view: self.view)

        
       //Text colors (Mutable)
        
        
       Core.setColorbyStringLength(myMutableString: self.myMutableString, text: self.recoverPasswordString, firstcolor: Core.hexStringToUIColor(hex: "#5ABFCC"), firstlocation: 25, firstlength: 10, secondcolor: .white, secondlocation: 0, secondlength: 24, button: self.passwordRecoverButton)
        
        
        //Setting facebook states
        self.checkLogin = false
        
        
        // initialize Account Kit
        if accountKit == nil {
            // may also specify AKFResponseTypeAccessToken
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
        
        
    }
    
    
    func callaAccountKit(){
        //login with Phone
        let inputState: String = UUID().uuidString
        let viewController: AKFViewController = accountKit.viewControllerForEmailLogin(withEmail: nil, state: inputState)  as AKFViewController
        viewController.enableSendToFacebook = true
        
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
    
    
    private func didReceiveFacebookLoginResult(loginResult: LoginResult) {
        
        switch loginResult {
        case .success:
            didLoginWithFacebook()
            
            
        case .failed(_): break
        default: break
        }
    }
    
    private func didLoginWithFacebook() {
        // Successful log in with Facebook
        if let accessToken = AccessToken.current {
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            facebookAPIManager.requestFacebookUser(completion: { (facebookUser) in
                self.checkLogin = true
                if let _ = facebookUser.email {
                    let info = "First name: \(facebookUser.firstName!) \n Last name: \(facebookUser.lastName!) \n Email: \(facebookUser.email!)"
                    
                    self.didLogin(method: "Facebook", info: info)
                }
            })
        }
    }
    
    private func didLogin(method: String, info: String) {
        
        self.checkUserIsRegistered = false
        
        if((FBSDKAccessToken.current()) != nil){
            
            let graphRequest = GraphRequest(graphPath: "me", parameters: self.paramsGraph)
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    
                    
                    if self.checkLogin == true && self.checkUserIsRegistered == false{
                        self.callaAccountKit()
                        if let responseDictionary = graphResponse.dictionaryValue {
                            self.saveFacebookDataArray.append(FacebookUserData(id: responseDictionary["id"] as? Int, name: responseDictionary["name"] as? String, firstName: responseDictionary["first_name"] as? String, lastName: responseDictionary["last_name"] as! String, email: responseDictionary["email"] as! String, gender: responseDictionary["gender"] as! String, birthday: responseDictionary["birthday"] as! String ))
                        }
                    }else if self.checkLogin == true && self.checkUserIsRegistered == true{
                        SwiftyBeaver.debug("already")
                        
                    }

                }
            }
        }
       
    }
    
    
    
    
    


}
