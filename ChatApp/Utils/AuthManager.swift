//
//  AuthManager.swift
//  ChatApp
//
//  Created by Tushar Patil on 15/09/23.
//

import Foundation
import Security

class AuthManager{
    
    static let shared = AuthManager()
    private init(){}
    private let accessTokenKey = "com.tushar.chat.AuthManager.accessTokenKey"
    private let userAuthKey = "com.tushar.chat.AuthManager.userAuthKey"
    private let userIDKey = "com.tushar.chat.userID"
    
    func saveUserID(id:String){
        UserDefaults.standard.setValue(id, forKey: userIDKey)
    }
    
    func getUserID() -> String{
        return UserDefaults.standard.string(forKey: userIDKey) ?? ""
    }
    
    func saveToken(accessToken:String){
        guard let tokenData = accessToken.data(using: .utf8) else {return}
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String:accessTokenKey,
            kSecValueData as String: tokenData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess{
            UserDefaults.standard.setValue(true, forKey: userAuthKey)
        }
    }
    
    func authenticated() -> Bool{
        return UserDefaults.standard.bool(forKey: userAuthKey)
    }
    
    func getToken() -> String{
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accessTokenKey,
            kSecReturnData as String: true
        ]
        var tokenData:AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &tokenData)
        if status == errSecSuccess, let data = tokenData as? Data, let token = String(data: data, encoding: .utf8){
            return token
        }
        return ""
    }
}
