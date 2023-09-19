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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginAction(){
        let viewModel = LoginViewModel()
        viewModel.request.email = tfEmail.text ?? ""
        viewModel.request.password = tfPassword.text ?? ""
        viewModel.login {[weak self] loginResponse, error in
            if error != nil{
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error ?? "")
            } else {
                if let response = loginResponse{
                    if !(response.status ?? false){
                        Alert.shared.showAlertWithOkBtn(title: "Error", message: response.message ?? "")
                    } else {
                        DispatchQueue.main.async {
                            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Tabbar"){
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
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
