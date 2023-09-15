//
//  SignupModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 15/09/23.
//

import Foundation


struct SignupRequest: Encodable{
    var name,email,password,confirmPassword:String?
}
