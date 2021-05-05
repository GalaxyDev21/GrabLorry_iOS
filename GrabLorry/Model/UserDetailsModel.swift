//
//  UserDetailsModel.swift
//  MyCarPartMarket
//
//  Created by RMV on 21/02/18.
//  Copyright © 2018 DiyaTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserDetailsModel : NSObject {
    
    var recid = ""
    var name = ""
    var email = ""
    var password = ""
    var mobile = ""
    var radius = ""
    var longitude = ""
    var latitude = ""
    var created = ""
    var status = ""
    var apikey = ""
    
    override init() {
        super.init()
    }
    
    
    init(Data:JSON) {
        super.init()

        if let recid = Data["recid"].string {
            self.recid = recid
        }
        if let name = Data["name"].string {
            self.name = name
        }
        if let email = Data["email"].string {
            self.email = email
        }
        if let password = Data["password"].string {
            self.password = password
        }
        if let mobile = Data["mobile"].string {
            self.mobile = mobile
        }
        if let radius = Data["radius"].string {
            self.radius = radius
        }
        if let longitude = Data["longitude"].string {
            self.longitude = longitude
        }
        if let latitude = Data["latitude"].string {
            self.latitude = latitude
        }
        if let created = Data["created"].string {
            self.created = created
        }
        if let status = Data["status"].string {
            self.status = status
        }
        if let apikey = Data["apikey"].string {
            self.apikey = apikey
        }
        saveToDefault()
    }
    
    func saveToDefault()
    {
        Defaults.set(dictionaryFromInfos(), forKey: User_Details)
        Defaults.synchronize()
    }
    
    /* save all infos to a dictionary */
    func dictionaryFromInfos() -> [String: Any] {
        
        var dicInfo = [String: Any]()
         dicInfo["recid"] = recid as String?
         dicInfo["name"] = name as String?
         dicInfo["email"] = email as String?
         dicInfo["password"] = password as String?
         dicInfo["radius"] = radius as String?
         dicInfo["mobile"] = mobile as String?
         dicInfo["longitude"] = longitude as String?
         dicInfo["latitude"] = latitude as String?
         dicInfo["created"] = created as String?
         dicInfo["status"] = status as String?
         dicInfo["apikey"] = apikey as String?
        
        return dicInfo
    }
    
    func logOut() {
        
        Defaults.removeObject(forKey: User_Details)
         Defaults.removeObject(forKey: "dlfradius")
         recid = ""
         name = ""
         email = ""
         password = ""
         mobile = ""
         radius = ""
         longitude = ""
         latitude = ""
         created = ""
         status = ""
         apikey = ""

        appInstance.goToLoginScreenPage(transition: true)
    }
}
