//
//  LottieController.swift
//  beerapp
//
//  Created by alex on 2/14/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import Lottie

class LottieController: UIViewController {

    // MARK: - Let/Var
    var myPlaces = [Places]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "logo")
        animationView.frame = CGRect(x: 0, y: 20, width: 100, height: 100)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        
        self.view.addSubview(animationView)
        animationView.play()
        animationView.loopAnimation = true
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.splashTimeOut), userInfo: nil, repeats: false)
        
        iconImageView.image = iconImageView.image!.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .white
        
    }
    
   
    //Selector to call our lottie
    @objc func splashTimeOut(){
        self.performSegue(withIdentifier: "LotietoSignInController", sender: self)
    }

    // MARK: - Actions
    
    
    // MARK: - Helpers/Initializers/Setups

}
