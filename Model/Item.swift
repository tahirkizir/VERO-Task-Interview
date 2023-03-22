//
//  item.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 11.03.2023.
//

import Foundation

class Item
{
    var BusinessUnitKey : String
    var businessUnit : String
    var colorCode : String
    var description : String
    var isAvailableInTimeTrackingKioskMode : Int
    var parentTaskID : String
    var preplanningBoardQuickSelect : String
    var sort : String
    var task : String
    var title : String
    var wageType : String
    var workingTime : String
    

    init(BusinessUnitKey:String,businessUnit:String,colorCode:String,description:String,isAvailableInTimeTrackingKioskMode:Int,parentTaskID:String,preplanningBoardQuickSelect:String,sort:String,task:String,title:String,wageType:String,workingTime:String)
    {
        self.BusinessUnitKey = BusinessUnitKey
        self.businessUnit = businessUnit
        self.colorCode = colorCode
        self.description = description
        self.isAvailableInTimeTrackingKioskMode = isAvailableInTimeTrackingKioskMode
        self.parentTaskID = parentTaskID
        self.preplanningBoardQuickSelect = preplanningBoardQuickSelect
        self.sort = sort
        self.task = task
        self.title = title
        self.wageType = wageType
        self.workingTime = workingTime
    }
    
}
