//
//  Network.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 17.03.2023.
//

import UIKit
import Alamofire

class Network
{
    static let headers : HTTPHeaders =
    [
        "Authorization": "Basic \(Network.loginAuthToken)",
        "Content-Type": "application/json"
    ]
    
    static let parameters =
    [
        "username": "\(Network.username)",
        "password": "\(Network.password)"
    ] as [String : Any]
    
    static let loginURL = "https://api.baubuddy.de/index.php/login"
    static let resourceURL = "https://api.baubuddy.de/dev/index.php/v1/tasks/select"
    static let username = "365"
    static let password = "1"
    static let loginAuthToken = "QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"
    
    var user : User?
    let HttpHeader = HTTPHeader(name:"Authorization",value:"Basic \(Network.loginAuthToken)")
     
 
    func loginServer(completion:@escaping(Bool,String?,User?,Session?)->Void)
    {
        AF.request(Network.loginURL, method: .post, parameters: Network.parameters, encoding: JSONEncoding.default, headers: Network.headers).responseJSON
        { (response:DataResponse) in
            
            do
            {
                switch(response.result)
                {
                case .success(_):
                    
                    let JSON = try JSONSerialization.jsonObject(with: response.data! as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                    
                    if let jsonResult = JSON as? Dictionary<String, AnyObject>
                    {
                        if let oauth = jsonResult["oauth"] as? [String:Any]
                        {
                            if let oauthAccessToken = oauth["access_token"] as? String
                            {
                                let (us,se) = self.parseServerAndUserInformation(jsonResult) ?? (nil,nil)
                                completion(true,oauthAccessToken,us,se)
                            }
                            else
                            {
                                completion(false,"1000",nil,nil)
                            }
                        }
                        else
                        {
                            completion(false,"1001",nil,nil)
                        }
                    }
                    else
                    {
                        completion(false,"1002",nil,nil)
                    }
                    
                case .failure(_):
                    completion(false,"1003",nil,nil)
                    break
                }
            }
            catch
            {
                completion(false,"1004",nil,nil)
            }
        }
    }
    
    func parseServerAndUserInformation(_ json:Dictionary<String, AnyObject>) -> (User,Session)?
    {
        guard let oauth = json["oauth"] as? [String:Any] else {return nil}
        
        let access_token = oauth["access_token"] as? String
        let expires_in = oauth["expires_in"] as? String
        let refresh_token = oauth["refresh_token"] as? String
        let scope = oauth["scope"] as? String
        let token_type = oauth["token_type"] as? String
        let showPasswordPrompt = oauth["showPasswordPrompt"] as? Int
        let apiVersion = oauth["apiVersion"] as? String
        
        let session = Session(access_token: access_token ?? "", expires_in: expires_in ?? "", refresh_token: refresh_token ?? "", scope: scope ?? "", token_type: token_type ?? "", showPasswordPrompt: showPasswordPrompt ?? 0, apiVersion: apiVersion ?? "")
        
        
        guard let userInfo = json["userInfo"] as? [String:Any] else {return nil}
        
        let permissions = json["permissions"] as? [String]
        let active = userInfo["active"] as? Int
        let businessUnit = userInfo["businessUnit"] as? String
        let displayName = userInfo["displayName"] as? String
        let firstName = userInfo["firstName"] as? String
        let lastName = userInfo["lastName"] as? String
        let personalNo = userInfo["personalNo"] as? Int
                
        let user = User(permissions: permissions ?? [String](), active: active ?? 0, businessUnit: businessUnit ?? "", displayName: displayName ?? "", firstName: firstName ?? "", lastName: lastName ?? "", personalNo: personalNo ?? 0)
        
        
        return (user,session)
    }
    
    func requestResource(_ accessToken:String,completion:@escaping(Bool,String?,[Item]?)->Void)
    {
        let headers: HTTPHeaders =
        [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        
        AF.request(Network.resourceURL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON
        { (response:DataResponse) in
            
            do
            {
                switch(response.result)
                {
                case .success(_):
                    
                    var itemArray = [Item]()
                    
                    let JSON = try JSONSerialization.jsonObject(with: response.data! as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                    print("JSON \(JSON)")
                    if let jsonResult = JSON as? [Dictionary<String, AnyObject>]
                    {
                        for i in jsonResult
                        {
                            let BusinessUnitKey = i["BusinessUnitKey"] as? String
                            let businessUnit = i["businessUnit"] as? String
                            let colorCode = i["colorCode"] as? String
                            let description = i["description"] as? String
                            let isAvailableInTimeTrackingKioskMode = i["isAvailableInTimeTrackingKioskMode"] as? Int
                            let parentTaskID = i["parentTaskID"] as? String
                            let preplanningBoardQuickSelect = i["preplanningBoardQuickSelect"] as? String
                            let sort = i["sort"] as? String
                            let task = i["task"] as? String
                            let title = i["title"] as? String
                            let wageType = i["wageType"] as? String
                            let workingTime = i["workingTime"] as? String
                            
                            let item = Item(BusinessUnitKey: BusinessUnitKey ?? "", businessUnit: businessUnit ?? "", colorCode: colorCode ?? "", description: description ?? "", isAvailableInTimeTrackingKioskMode: isAvailableInTimeTrackingKioskMode ?? 0, parentTaskID: parentTaskID ?? "", preplanningBoardQuickSelect: preplanningBoardQuickSelect ?? "", sort: sort ?? "", task: task ?? "", title: title ?? "", wageType: wageType ?? "", workingTime: workingTime ?? "")
                            
                            itemArray.append(item)
                        }
                        completion(true,nil,itemArray)
                    }
                    else
                    {
                        completion(false,"1006",nil)
                    }
                    
                case .failure(_):
                    completion(false,"1007",nil)
                    break
                }
            }
            catch
            {
                completion(false,"1008",nil)
            }
        }
    }
}
