//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import Foundation


class LoginViewModel{
    
    var request = LoginRequest()
    
    func login(completion:@escaping(LoginResponse?,String?) -> Void){
        if validated(){
            APICaller.shared.request(url: .login, method: .post, body: request, responseType: LoginResponse.self) { response, error in
                completion(response,error)
            }
        } else {
            completion(nil, "Email or password is invalid")
        }
    }
    func validated() -> Bool{
        return (request.email?.isValidEmail() ?? false) && (request.password?.isValidPassword() ?? false)
    }
}
