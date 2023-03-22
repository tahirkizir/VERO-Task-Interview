//
//  user.swift
//  SkyAD
//
//  Created by Tahir Kizir on 3.06.2021.
//  Copyright © 2021 Dev. All rights reserved.
//

import Foundation


class User
{
    var permissions : [String]
    var active : Int
    var businessUnit : String
    var displayName : String
    var firstName : String
    var lastName : String
    var personalNo : Int
    
    
    init(permissions:[String],active:Int,businessUnit:String,displayName:String,firstName:String,lastName:String,personalNo:Int)
    {
        self.permissions = permissions
        self.active = active
        self.businessUnit = businessUnit
        self.displayName = displayName
        self.firstName = firstName
        self.lastName = lastName
        self.personalNo = personalNo
    }
    
}
