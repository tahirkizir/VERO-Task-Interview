//
//  CoreData.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 17.03.2023.
//

import Foundation
import CoreData
import UIKit

let nw = Network()

class CoreData
{
    func cdus(_ user:User)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let us = NSManagedObject(entity: entity!, insertInto: context)
        us.setValue(user.active, forKey: "active")
        us.setValue(user.businessUnit, forKey: "businessUnit")
        us.setValue(user.displayName, forKey: "displayName")
        us.setValue(user.firstName, forKey: "firstName")
        us.setValue(user.lastName, forKey: "lastName")
        us.setValue(user.personalNo, forKey: "personalNo")
        var pm = "";for i in user.permissions {pm.append("\(i)-")};if !pm.isEmpty{pm.removeLast()}
        us.setValue(pm, forKey: "permissions")
        do
        {
            try context.save()
        }
        catch
        {}
    }
    
    func cdcs(_ session:Session)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Sessions", in: context)
        let ses = NSManagedObject(entity: entity!, insertInto: context)
        
        ses.setValue(session.access_token, forKey: "access_token")
        ses.setValue(session.apiVersion, forKey: "apiVersion")
        ses.setValue(session.expires_in, forKey: "expires_in")
        ses.setValue(session.refresh_token, forKey: "refresh_token")
        ses.setValue(session.scope, forKey: "scope")
        ses.setValue(session.showPasswordPrompt, forKey: "showPasswordPrompt")
        ses.setValue(session.token_type, forKey: "token_type")
        do
        {
            try context.save()
        }
        catch
        {}
    }
    
    func cfis(_ its: [Item])
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Items", in: context)
        
        
        for it in its
        {
            let itm = NSManagedObject(entity: entity!, insertInto: context)
            itm.setValue(it.businessUnit, forKey: "businessUnit")
            itm.setValue(it.workingTime, forKey: "workingTime")
            itm.setValue(it.wageType, forKey: "wageType")
            itm.setValue(it.title, forKey: "title")
            itm.setValue(it.task, forKey: "task")
            itm.setValue(it.sort, forKey: "sort")
            itm.setValue(it.preplanningBoardQuickSelect, forKey: "preplanningBoardQuickSelect")
            itm.setValue(it.parentTaskID, forKey: "parentTaskID")
            itm.setValue(it.isAvailableInTimeTrackingKioskMode, forKey: "isAvailableInTimeTrackingKioskMode")
            itm.setValue(it.colorCode, forKey: "colorCode")
            itm.setValue(it.description, forKey: "desc")
            itm.setValue(it.BusinessUnitKey, forKey: "businessUnitKey")
            do
            {
                try context.save()
            }
            catch
            {}
        }
    }
    
    func cdug() -> User
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject]
            {
                let active = object.value(forKey: "active") as! Int
                let businessUnit = object.value(forKey: "businessUnit") as! String
                let displayName = object.value(forKey: "displayName") as! String
                let firstName = object.value(forKey: "firstName") as! String
                let lastName = object.value(forKey: "lastName") as! String
                let personalNo = object.value(forKey: "personalNo") as! Int
                let permissions = object.value(forKey: "permissions") as! String
                let permissionArray = permissions.components(separatedBy: "-")
                
                
                return User(permissions: permissionArray, active: active, businessUnit: businessUnit, displayName: displayName, firstName: firstName, lastName: lastName, personalNo: personalNo)
            }
        }
        catch
        {}
        
        return User(permissions: [String](), active: 0, businessUnit: "", displayName: "", firstName: "", lastName: "", personalNo: 0)
    }
    
    func cdcg() -> Session
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Sessions")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let result = try context.fetch(request)
            for object in result as! [NSManagedObject]
            {
                let access_token = object.value(forKey: "access_token") as! String
                let apiVersion = object.value(forKey: "apiVersion") as! String
                let expires_in = object.value(forKey: "expires_in") as! String
                let refresh_token = object.value(forKey: "refresh_token") as! String
                let scope = object.value(forKey: "scope") as! String
                let showPasswordPrompt = object.value(forKey: "showPasswordPrompt") as! Int
                let token_type = object.value(forKey: "token_type") as! String
                
                return Session(access_token: access_token, expires_in: expires_in, refresh_token: refresh_token, scope: scope, token_type: token_type, showPasswordPrompt: showPasswordPrompt, apiVersion: apiVersion)
            }
        }
        catch
        {}
        
        return Session(access_token: "", expires_in: "", refresh_token: "", scope: "", token_type: "", showPasswordPrompt: 0, apiVersion: "")
    }
    
    func cdig() -> [Item]
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Items")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let result = try context.fetch(request)
            var itemList = [Item]()
            for object in result as! [NSManagedObject]
            {
                let BusinessUnitKey = object.value(forKey: "businessUnitKey") as! String
                let businessUnit = object.value(forKey: "businessUnit") as! String
                let workingTime = object.value(forKey: "workingTime") as! String
                let wageType = object.value(forKey: "wageType") as! String
                let title = object.value(forKey: "title") as! String
                let task = object.value(forKey: "task") as! String
                let sort = object.value(forKey: "sort") as! String
                let preplanningBoardQuickSelect = object.value(forKey: "preplanningBoardQuickSelect") as! String
                let parentTaskID = object.value(forKey: "parentTaskID") as! String
                let isAvailableInTimeTrackingKioskMode = object.value(forKey: "isAvailableInTimeTrackingKioskMode") as! Int
                let colorCode = object.value(forKey: "colorCode") as! String
                let description = object.value(forKey: "desc") as! String
                
                itemList.append(Item(BusinessUnitKey: BusinessUnitKey, businessUnit: businessUnit, colorCode: colorCode, description: description, isAvailableInTimeTrackingKioskMode: isAvailableInTimeTrackingKioskMode, parentTaskID: parentTaskID, preplanningBoardQuickSelect: preplanningBoardQuickSelect, sort: sort, task: task, title: title, wageType: wageType, workingTime: workingTime))
            }
            return itemList
        }
        catch
        {}
        
        return [Item]()
    }
    
    func cdtst() -> Bool
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let result = try context.fetch(request)
            if result.isEmpty {return false} else {return true}
        }
        catch
        {
            return false
        }
    }
    
    func dltcdu()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let result = try managedContext.fetch(request)
            for object in result as! [NSManagedObject]
            {
                managedContext.delete(object)
            }
        }
        catch
        {}
    }
    
    func dltcdc()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Sessions")
        
        do
        {
            let result = try managedContext.fetch(request)
            for object in result as! [NSManagedObject]
            {
                managedContext.delete(object)
            }
        }
        catch
        {}
    }
    
    func dltcdi()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Items")
        
        do
        {
            let result = try managedContext.fetch(request)
            for object in result as! [NSManagedObject]
            {
                managedContext.delete(object)
            }
        }
        catch
        {}
    }
    
    func lld() -> Bool
    {
        if UserDefaults.standard.value(forKey: "lastLogin") as? String == nil {return false}
        let d = Date()
        let x = DateFormatter()
        let y = x.string(from: d)
        UserDefaults.standard.setValue(y, forKey: "lastLogin")
        let cr = cdcg()
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = df.date(from: cr.expires_in)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day,.hour], from: date ?? d)
        let fdE = calendar.date(from: components)
        if (fdE ?? Date()) >= d{UserDefaults.standard.setValue(nil, forKey: "lastLogin");return false}else{return true}
    }
    
    func cdc() -> (Session,User,[Item],(Bool,String))
    {
        let cr = cdcg()
        let it = cdig()
        let us = cdug()
        return(cr,us,it,(true,cr.access_token))
    }
    
    func sst(completion:@escaping(Session?,User?,[Item]?,(Bool,String))->Void)
    {
        nw.loginServer() { [self] ls,tx,us,cr   in
                    
                    if ls
                    {
                        nw.requestResource(tx!) { [self] ls, txm, it in
                            
                            if ls
                            {
                                if cdtst() {dltcdu();dltcdc();dltcdi()}
                                cdcs(cr!)
                                cdus(us!)
                                cfis(it!)
                                completion(cr!,us!,it!,(true,tx!))
                            }
                            else
                            {
                                completion(nil,nil,nil,(false,txm!))
                            }
                        }
                    }
                    else
                    {
                        completion(nil,nil,nil,(false,tx!))
                    }
                }
        }
}
