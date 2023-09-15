//
//  LoginModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import Foundation

struct LoginRequest:Encodable{
    var email,password:String?
}

struct LoginResponse:Decodable{
    var status:Bool?
    var statusCode:Int?
    var message:String?
    var token:String?
    var data:UserData?
}

struct UserData: Decodable {
    let id, name, email, password: String
    let pic: String
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, password, pic, createdAt, updatedAt
        case v = "__v"
    }
}
