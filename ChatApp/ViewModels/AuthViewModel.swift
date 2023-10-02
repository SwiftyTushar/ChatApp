//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

protocol DefaultViewModelDelegate{
    func success()
    func failure(msg:String)
}

class AuthViewModel{
    
    var delegate:DefaultViewModelDelegate?
    
    var signupRequest = SignupRequest()
    
    var loginRequest = LoginRequest()
    
    //MARK: Signup
    func signup(){
        guard validateSignup() else {return}
        
        APICaller.shared.request(url: .signup, method: .post, body: signupRequest, responseType: AuthResponse.self) {[weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    if response.success{
                        self?.saveTokenAndUserID(token: response.token, id: response.userId)
                        self?.delegate?.success()
                    } else {
                        self?.delegate?.failure(msg: response.message)
                    }
                } else {
                    self?.delegate?.failure(msg: "Parsing failed! try again!")
                }
            }
        }
    }
    private func saveTokenAndUserID(token:String?,id:String?){
        AuthManager.shared.saveToken(accessToken: token ?? "")
        AuthManager.shared.saveUserID(id: id ?? "")
    }
    
    private func validatePassword() -> Bool{
        if signupRequest.confirmPasword == signupRequest.password{
            return true
        }
        Alert.shared.showAlertWithOkBtn(title: "Error", message: "Passwords don't match")
        return false
    }
    
    private func validateEmail() -> Bool{
        if signupRequest.email?.isValidEmail() == true{
            return true
        }
        Alert.shared.showAlertWithOkBtn(title: "Error", message: "Enter a valid email")
        return false
    }
    private func validateUsername() -> Bool{
        return signupRequest.username?.isEmpty != true
    }
    private func validateSignup() -> Bool{
        return validatePassword() && validateEmail() && validateUsername()
    }
    //MARK: Login
    func login(){
        guard validateLogin() else {return}
        APICaller.shared.request(url: .login, method: .post, body: loginRequest, responseType: AuthResponse.self) { [weak self] response, error in
            if error != nil{
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error!)
            } else {
                if let response = response{
                    if response.success{
                        self?.saveTokenAndUserID(token: response.token, id: response.userId)
                        self?.delegate?.success()
                    } else {
                        self?.delegate?.failure(msg: response.message)
                    }
                }
            }
        }
    }
    private func validateLogin() -> Bool{
        return loginRequest.email?.isValidEmail() == true && loginRequest.password?.isEmpty == false
    }
}

