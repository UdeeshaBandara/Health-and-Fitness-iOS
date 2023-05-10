//
//  NetworkManager.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-10.
//

import Foundation
import Alamofire
import SwiftyJSON
import JGProgressHUD

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func defaultNetworkRequest(url : String,header : HTTPHeaders = ["" : ""], param : Dictionary<String, Any> = ["" : ""], requestMethod :Alamofire.HTTPMethod = .get, showIndicator : Bool = false, indicatorParent : UIView = UIView(), progressText : String = "",encoder : ParameterEncoding = URLEncoding.default, success successBlock : @escaping (JSON)-> Void, fail failureBlock : @escaping (String) -> Void)  {
        
        
       
        let progress = JGProgressHUD(style: .extraLight)
        
        if showIndicator {
            progress.textLabel.text = progressText
            progress.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 10.0, opacity: 0.1)
            progress.show(in: indicatorParent)
        }
            
        AF.request(url, method: requestMethod, parameters: param, encoding: encoder, headers:["Accept" : "application/json"]).response { response in
                
                do {
                    if let data = response.data {
                        
                        let jsonData = try JSON(data: data)
                        successBlock(jsonData)
                        
                    }else {
                        
                        failureBlock(response.error.debugDescription)
                    }
                    
                }catch let ex {
                    failureBlock(ex.localizedDescription)
                    
                }
            }
        
        if showIndicator {
            
            progress.dismiss()
        }
        
    }
    
    
}
