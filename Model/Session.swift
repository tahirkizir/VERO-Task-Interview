//
//  server.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 10.03.2023.
//

import Foundation


class Session
{
    var access_token : String
    var expires_in : String
    var refresh_token : String
    var scope : String
    var token_type : String
    var showPasswordPrompt : Int
    var apiVersion : String
    
    init(access_token:String,expires_in:String,refresh_token:String,scope:String,token_type:String,showPasswordPrompt:Int,apiVersion:String)
    {
        self.access_token = access_token
        self.expires_in = expires_in
        self.refresh_token = refresh_token
        self.scope = scope
        self.token_type = token_type
        self.showPasswordPrompt = showPasswordPrompt
        self.apiVersion = apiVersion
    }
}
