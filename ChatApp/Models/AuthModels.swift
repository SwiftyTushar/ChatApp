//
//  AuthModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

struct SignupRequest: Encodable{
    var email,username,password,confirmPasword:String?
}
struct AuthResponse: Decodable{
    var success:Bool
    var message:String
    var token:String?
    var userId:String?
}
struct LoginRequest: Encodable{
    var email,password:String?
}
