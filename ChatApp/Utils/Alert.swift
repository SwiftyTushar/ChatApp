//
//  Alert.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import UIKit

class Alert{
    
    private init(){}
    
    static let shared = Alert()
    
    func showAlertWithOkBtn(title:String,message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    }
}

