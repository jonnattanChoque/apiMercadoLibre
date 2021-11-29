//
//  AlamofireItem.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation
import UIKit
import Alamofire

class AlamofireItem{
    
    /// Function that consumes the api to fetch items by word
    /// - Parameter search: String item to search
    func getItems(search: String){
        Alamofire.request("\(Common.APIRest.URL_SEARCH)\(search)").responseJSON { response in
            switch response.result{
            case .success(let result):
                let results = result as? NSDictionary
                let jsonData = self.jsonToData(json: results?["results"] as Any)
                let decoder = JSONDecoder()
                
                do {
                    let resultItem = try decoder.decode([Item].self, from: jsonData!)
                    let result:[String: [Item]] = ["result": resultItem]
                    
                    if resultItem.count > 0{
                        NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Items.notificationSuccess),object:nil,userInfo:result)
                    }else{
                        let result:[String: String] = ["error": "No hay resultados"]
                        NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Items.notificationError),object:nil,userInfo:result)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    let result:[String: String] = ["error": "No hay resultados"]
                    NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Items.notificationError), object:nil, userInfo: result)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let result:[String: String] = ["error": "No es posible realizar la búsqueda en este momento"]
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Items.notificationError), object:nil, userInfo: result)
            }
        }
    }
    
    
    /// Function that transforms a json to data
    /// - Parameter json: Json data
    /// - Returns: Data to convert to an Object
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}
