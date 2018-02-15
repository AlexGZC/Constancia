//
//  FindPlacesViewController.swift
//  beerapp
//
//  Created by elaniin on 1/29/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyBeaver
import SwiftyJSON
import NVActivityIndicatorView

class FindPlacesController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Let/Var/IBOutlet
    
    var array = [Places]()
    var savetag = Int()
    var states: Bool?
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var searchPlacesBar: UISearchBar!
    @IBOutlet weak var placesMapkit: MKMapView!

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setUP()
        
        GetAPIManager.Get("http://demo8323091.mockable.io/get", success: { (response) in
            self.startAnimating()
            
            if let resData = response.arrayObject as? [[String: Any]] {
                self.array = resData.map(Places.init)
            }
            
            if self.array.count > 0{
                self.stopAnimating()
            }
            
            
            self.getAnnotations(array: self.array)
            
            
            
            
        }) { (error) in
            
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        

        //---Pruebas
//        self.states = true
//
//        if self.states == true{
//
//            let showPopup = UIStoryboard(name: "FIndPlaces", bundle: nil).instantiateViewController(withIdentifier: "3") as! PopUpViewController
//
//        showPopup.modalPresentationStyle = .popover
//
//        showPopup.popoverPresentationController?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
//
//        showPopup.popoverPresentationController?.sourceView = view
//
//        showPopup.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
//
//        
//        self.view.addSubview(showPopup.view)
//
//        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
    }
    
    // MARK: - IBActions
    

    
    // MARK: - Helpers/Initializers/Setups
    
    
    func setUP(){
                Core.itembarbackground(controller: self, barTint: Core.hexStringToUIColor(hex: "#213363"), titleColor: Core.hexStringToUIColor(hex: "#59BCCA"))
        
        let textFieldInsideUISearchBar = searchPlacesBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.borderStyle = .none
        textFieldInsideUISearchBar?.backgroundColor = UIColor.white
        
        searchPlacesBar.backgroundImage = UIImage()
    }
    
    private func getAnnotations(array:[Places]){
        
        for i in array{
            
            let location = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: i.lat, longitude: i.long))
            
            let span              = MKCoordinateSpanMake(10.0, 10.0)
            let region            = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: i.lat, longitude: i.long), span)
            
            let url = NSURL(string: i.img)
            DispatchQueue.global().async {
                self.startAnimating()
                let data = try? Data(contentsOf: url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.stopAnimating()
                    location.image = UIImage(data: data!)
                    
                }
            }
            
            // location.image =
            location.name = i.name
            location.tag = i.tag
            
            self.placesMapkit.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.title = i.name
            self.placesMapkit.addAnnotation(location)
            
        }
    }
    
    
    
    
    @objc func connected(_ sender:AnyObject){
        SwiftyBeaver.debug("Sii")
        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let passSecondController = storyboard.instantiateViewController(withIdentifier: "animeDetails") as! ViewController
         
         passSecondController.getName = self.array[self.savetag].name
         present(passSecondController, animated: true , completion: nil)
         */
    }
    
}


