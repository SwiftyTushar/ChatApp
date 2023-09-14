//
//  LoginVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginAction(){
        viewModel.request.email = tfEmail.text ?? ""
        viewModel.request.password = tfPassword.text ?? ""
        viewModel.login { loginResponse, error in
            if error != nil{
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error ?? "")
            } else {
                if let response = loginResponse{
                    if !(response.status ?? false){
                        Alert.shared.showAlertWithOkBtn(title: "Error", message: response.message ?? "")
                    } else {
                        
                    }
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
