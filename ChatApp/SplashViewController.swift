//
//  SplashViewController.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            if AuthManager.shared.authenticated(){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageListVC") as! MessageListVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetStartedVC") as! GetStartedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }


}

