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
    private let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your profile"
        profilePicImg.isUserInteractionEnabled = true
        profilePicImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfileClicked)))
    }
    @objc func onProfileClicked(){
        imgPicker.sourceType = .photoLibrary
        
        self.present(imgPicker, animated: true)
    }
    @IBAction func onConinueClicked(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MessageListVC") as! MessageListVC
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
