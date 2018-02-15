//
//  Core.swift
//  App
//
//  Created by elaniin on 1/15/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation
import UIKit
import AccountKit

//Core will be used to get elements/ functions which don`t neeed to be created for each class


class Core{
    static let shared = Core()
    private init() {}
    
    //MARK: - Alert view
    static func alert(message: String, title: String, at viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - CircleImage
    
    func circleimage(imageview: UIImageView){
        imageview.layoutIfNeeded()
        imageview.layer.cornerRadius = imageview.frame.width / 2
        imageview.clipsToBounds = true
        
        
    }
    
    //Buttoncircle
     func circlebutton(button: UIButton){
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        
    }
    
    
    //Imagebackground
    func setbackground(image: String, view: UIView){
        let background = UIImage(named: image)
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    /// MARK: - Validations
    
    
    //MARK: - Hexa string color turn into UIColor
    static func hexStringToUIColor (hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    static func setColorbyStringLength( myMutableString:NSMutableAttributedString,text: String,firstcolor:UIColor, firstlocation: Int, firstlength:Int,secondcolor:UIColor, secondlocation: Int, secondlength:Int,button:UIButton){
        var mutable = myMutableString
        mutable = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)])
        
        mutable.addAttribute(NSAttributedStringKey.foregroundColor, value: firstcolor, range: NSRange(location:firstlocation,length:firstlength))
        
        mutable.addAttribute(NSAttributedStringKey.foregroundColor, value: secondcolor, range: NSRange(location:secondlocation,length:secondlength))
        
        button.setAttributedTitle(mutable, for: .normal)
    }
    
    /// MARK: - Animations
    
    
    static func Scale(view:UIView){
        UIView.animate(withDuration: 0.5,
                       animations: {
                        
                        view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.4) {
                            view.transform = CGAffineTransform.identity
                        }
        })
    }
    
    static func Fade(view:UIView){
        view.alpha = 0
        view.fadeOut(completion: {
            (finished: Bool) -> Void in
            view.fadeIn()
        })
    }
    
    static func Fade2(view:UIView){
        view.transform = view.transform.scaledBy(x: 0.001, y: 0.001)
        
        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    //Navbar color
    static func itembarbackground(controller: UIViewController, barTint: UIColor, titleColor: UIColor){
        
        controller.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        controller.navigationController?.navigationBar.isTranslucent = false
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.barTintColor  = barTint
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: titleColor]
        controller.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        
    }
    
    /// MARK: - Table Views
    
    /// Register cell at a table view
    func registerCell(at tableView: UITableView, named: String, withIdentifier: String? = nil) {
        let coffeeCellNib = UINib(nibName: named, bundle: nil)
        tableView.register(coffeeCellNib, forCellReuseIdentifier: withIdentifier ?? named)
    }

    
    
    
    
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}


extension UIView {
    
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}


class MyTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 16, 0, 16))
    }
}




