//
//  NavigationHelper.swift
//  ChatApp
//
//  Created by Tushar Patil on 30/09/23.
//

import UIKit

class NavigationHelper{
    
    static func rootToTabbar(){
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tabbar")
            let navVC = UINavigationController(rootViewController: vc)
            navVC.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.windows.first?.rootViewController = navVC
        }
    }
}

