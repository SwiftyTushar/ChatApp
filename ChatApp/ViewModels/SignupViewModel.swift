//
//  SignupViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 15/09/23.
//

import Foundation

class SignupViewModel{
    var request = SignupRequest()
    
    func signup(completion:@escaping(Bool) -> Void){
        
        guard validated() else {completion(false);return}
        
        APICaller.shared.request(url: .signup, method: .post, body: request, responseType: LoginResponse.self) { response, error in
            if error != nil{
                completion(false)
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error ?? "")
            } else {
                if let response = response{
                    if response.status ?? false{
                        AuthManager.shared.saveToken(accessToken: response.token ?? "")
                        completion(true)
                    } else {
                        completion(false)
                        Alert.shared.showAlertWithOkBtn(title: "Error", message: response.message ?? "")
                    }
                }
            }
        }
    }
    private func passwordValid() -> Bool{
        if request.password?.isValidPassword() ?? false{
            if request.confirmPassword != request.password{
                Alert.shared.showAlertWithOkBtn(title: "Error", message: "Passwords don't match")
                return false
            }
            return true
        }
        Alert.shared.showAlertWithOkBtn(title: "Error", message: "This password is not secured, try another")
        return false
    }
    private func isNameValid() -> Bool{
        if !(request.name?.isEmpty ?? false){
            return true
        }
        Alert.shared.showAlertWithOkBtn(title: "Error", message: "Name is not valid")
        return false
    }
    private func isEmailValid() -> Bool{
        if (request.email?.isValidEmail() ?? false){
            return true
        }
        Alert.shared.showAlertWithOkBtn(title: "Erro", message: "Invalid Email")
        return false
    }
    private func validated() -> Bool{
        return isEmailValid() && isNameValid() && self.passwordValid()
    }
}
