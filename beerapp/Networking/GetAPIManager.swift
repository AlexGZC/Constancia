//
//  Data.swift
//  Papajohns
//
//  Created by alex on 10/17/17.
//  Copyright © 2017 elaniin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetAPIManager: NSObject{
    enum BackendError: Error {
        case urlError(reason: String)
        case objectSerialization(reason: String)
    }
    
    class func Get(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL, method: .get, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
            
            //print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
                
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    
    class func Post(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    

    
    
    
    
}



