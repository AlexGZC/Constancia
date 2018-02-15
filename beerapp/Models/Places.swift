//
//  Places.swift
//  La constancia App
//
//  Created by elaniin on 1/10/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

struct Places {
    
    var tag: Int?
    var msg = String()
    var lat = Double()
    var long = Double()
    var info = Dictionary<String,Any>()
    var name = String()
    var img = String()
    
    init(dictionary: [String:Any]) {
        self.tag = dictionary["tag"] as? Int ?? 1
        self.msg = dictionary["msg"] as? String ?? "Mensaje prueba"
        self.lat = dictionary["lat"] as? Double ?? 0.11
        self.long = dictionary["lon"] as? Double ?? -0.11
        self.info = dictionary["info"] as? Dictionary<String,Any> ?? ["error":"error" as Any]
        self.name = info["name"] as? String ?? "My name"
        self.img = info["image"] as? String ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_El_Salvador.svg/1200px-Flag_of_El_Salvador.svg.png"
    }

    
    
}



