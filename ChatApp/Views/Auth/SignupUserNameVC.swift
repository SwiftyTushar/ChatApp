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
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicImg.layer.cornerRadius = profilePicImg.frame.height/2
        title = ""
        profilePicImg.isUserInteractionEnabled = true
        profilePicImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfileClicked)))
        profilePicImg.layer.borderColor = UIColor.black.cgColor
        profilePicImg.layer.borderWidth = 1
        imgPicker.delegate = self
        viewModel.delegate = self
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor.black // Change the color of the back button arrow

            // Change the color of the back button title
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        }
    }
    @objc func onProfileClicked(){
        imgPicker.sourceType = .photoLibrary
        
        self.present(imgPicker, animated: true)
    }
    @IBAction func onConinueClicked(){
        viewModel.signupRequest.username = tfName.text
        viewModel.signupRequest.email = tfEmail.text
        viewModel.signupRequest.password = tfPassword.text
        viewModel.signupRequest.confirmPasword = tfConfirmPassword.text
        viewModel.signup()
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
//MARK: AuthViewModelDelegate (DefaultViewModelDelegate)
extension SignupUserNameVC: DefaultViewModelDelegate{
    func success() {
        NavigationHelper.rootToPeopleYouManKnow()
    }
    
    func failure(msg: String) {
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
    
}
//MARK: UIImagePickerControllerDelegate
extension SignupUserNameVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profilePicImg.image = selectedImage
            profilePicImg.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
    }
}
