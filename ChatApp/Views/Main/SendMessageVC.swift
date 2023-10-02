//
//  SendMessageVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 11/09/23.
//

import UIKit
import IQKeyboardManager

class SendMessageVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tfMessage:UITextField!
    @IBOutlet weak var sendMessageView:UIView!
    @IBOutlet weak var sendMessageViewBottomConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MessageSentTVC", bundle: nil), forCellReuseIdentifier: "MessageSentTVC")
        title = "Tushar Patil"
        tableView.register(UINib(nibName: "MessageRecievedTVC", bundle: nil), forCellReuseIdentifier: "MessageRecievedTVC")
        sendMessageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        sendMessageView.layer.cornerRadius = 8
        tfMessage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldClicked)))
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Add an observer for the keyboard becoming inactive
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        fetchPreviousMessages()
    }
    private func fetchPreviousMessages(){
        
    }
    @objc private func hideKeyboard(){
        tfMessage.resignFirstResponder()
    }
    // Selector method for when the keyboard becomes active
    @objc func keyboardDidShow(_ notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: []) {[weak self] in
                self?.sendMessageViewBottomConstraint.constant = -(keyboardHeight-20)
                self?.view.layoutIfNeeded()
            }
            self.sendMessageViewBottomConstraint.constant = -(keyboardHeight - 20)
        }
    }
    
    // Selector method for when the keyboard becomes inactive
    @objc func keyboardDidHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: []) {[weak self] in
            self?.sendMessageViewBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        tfMessage.inputAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    override func viewWillDisappear(_ animated:Bool){
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    @objc func textFieldClicked(){
        
        tfMessage.becomeFirstResponder()
    }
    @IBAction func sendMessageAction(){
        
    }
    @objc func backBtnAction(){
        navigationController?.popViewController(animated: true)
    }

}
//MARK: UITableViewDelegate,UITableViewDataSource
extension SendMessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
