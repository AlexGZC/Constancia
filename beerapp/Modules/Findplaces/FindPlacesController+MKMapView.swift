//
//  FindPlacesViewControllerExtensionViewController.swift
//  beerapp
//
//  Created by elaniin on 1/29/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import MapKit

extension FindPlacesController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.placesMapkit.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "icon-places-pin")
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom calloutz
            return
        }
        
        // 2
        let placeAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        //calloutView.placeName.text = placeAnnotation.name
        //calloutView.placeAddress.text = placeAnnotation.address
        //calloutView.placePhone.text = placeAnnotation.phone
        calloutView.iconPromotionImageView.image = placeAnnotation.image
        
        if self.placesMapkit.selectedAnnotations.count > 0 {
            
            if (self.placesMapkit.selectedAnnotations[0] as? MKAnnotation) != nil {
                
                SwiftyBeaver.verbose("selected annotation: \(placeAnnotation.tag)")
                self.savetag = placeAnnotation.tag
                
                
                //do something else with ann...
            }
        }
        
        
        let button = UIButton(frame: calloutView.iconPromotionImageView.frame)
        
        button.addTarget(self, action: #selector(FindPlacesController.connected(_:)), for: .touchUpInside)
        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
}
