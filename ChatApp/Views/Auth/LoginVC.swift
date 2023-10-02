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
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    @IBAction func loginAction(){
        viewModel.loginRequest.email = tfEmail.text
        viewModel.loginRequest.password = tfPassword.text
        viewModel.login()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
//MARK: ViewModelDelegate
extension LoginVC: DefaultViewModelDelegate{
    func success() {
        NavigationHelper.rootToTabbar()
    }
    
    func failure(msg: String) {
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
    
}
