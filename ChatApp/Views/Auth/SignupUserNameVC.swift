//
//  SignupUserNameVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit

class SignupUserNameVC: BaseViewController {
    
    @IBOutlet weak var profilePicImg:UIImageView!
    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    @IBOutlet weak var tfConfirmPassword:UITextField!
    
    private let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        profilePicImg.isUserInteractionEnabled = true
        profilePicImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfileClicked)))
    }
    @objc func onProfileClicked(){
        imgPicker.sourceType = .photoLibrary
        
        self.present(imgPicker, animated: true)
    }
    @IBAction func onConinueClicked(){
        let viewModel = SignupViewModel()
        
        viewModel.request.name = tfName.text
        viewModel.request.email = tfEmail.text
        viewModel.request.password = tfPassword.text
        viewModel.request.confirmPassword = tfConfirmPassword.text
        
        viewModel.signup {[weak self] success in
            if success{
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Tabbar"){
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        
    }
    @IBAction func loginAction(){
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
//MARK: UIImagePickerControllerDelegate
extension SignupUserNameVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
