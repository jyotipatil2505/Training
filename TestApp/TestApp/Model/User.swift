//
//  User.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 24/11/20.
//

import Foundation

//Model
struct User
{
    var name: String = ""
    var username: String = ""
    var password: String = ""
    
    init(name:String, username:String, password:String)
    {
        self.name = name
        self.username = username
        self.password = password
    }
}
