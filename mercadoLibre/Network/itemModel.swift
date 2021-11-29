//
//  itemModel.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation

class itemModel {
    static let sharedInstance = itemModel()
    
    var delegate: ReloadViewDelegate? = nil
    private var network: AlamofireItem = AlamofireItem()
    private var items: [Item] = [Item]()
    
    init() {
        createObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSuccess(_:)), name: Notification.Name(rawValue: Common.Notifications.Items.notificationSuccess), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onError(_:)), name: Notification.Name(rawValue: Common.Notifications.Items.notificationError), object: nil)
    }
    
    /// Function of a valid response from an observer
    /// - Parameter notification: NSNotification with response Object Item
    @objc func onSuccess(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue: Common.Notifications.Items.notificationSuccess){
            self.items = notification.userInfo?["result"] as! [Item]
            notifyDelegate()
        }
    }
    
    /// Function of a error response from an observer
    /// - Parameter notification: NSNotification with response Object error
    @objc func onError(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue: Common.Notifications.Items.notificationError){
            self.items = [Item]()
            let error = notification.userInfo?["error"] as! String
            notifyErrorDelegate(message: error)
        }
    }
    
    /// Function that executes the valid delegate of a controller
    public func notifyDelegate(){
        if delegate != nil{
            delegate?.reloadView()
        }
    }
    
    /// Function that executes the error delegate of a controller
    /// - Parameter message: String error message
    public func notifyErrorDelegate(message:String){
        if delegate != nil{
            delegate?.errorLoading(message: message)
        }
    }
    
    /// Intermediate function to consult the items of an api
    /// - Parameter search: String item to search
    public func search(search:String?){
        network.getItems(search: search!)
    }
    
    /// Function that returns the items object
    /// - Returns: Array of Item Object
    public func dataSource()->[Item]{
        return items
    }
}
