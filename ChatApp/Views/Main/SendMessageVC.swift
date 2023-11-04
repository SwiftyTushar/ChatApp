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
    @IBOutlet weak var sendButton:ActivityIndictorButton!
    
    var chatID = String()
    var userID = String()
    private let viewModel = MessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfMessage.textColor = .black
        tableView.register(UINib(nibName: "MessageSentTVC", bundle: nil), forCellReuseIdentifier: "MessageSentTVC")
        tableView.register(UINib(nibName: "MessageRecievedTVC", bundle: nil), forCellReuseIdentifier: "MessageRecievedTVC")
        sendMessageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        sendMessageView.layer.cornerRadius = 8
        tfMessage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldClicked)))
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Add an observer for the keyboard becoming inactive
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        viewModel.delegate = self
        fetchPreviousMessages()
        tfMessage.autocorrectionType = .no
        tableView.backgroundColor = .white
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor.black // Change the color of the back button arrow

            // Change the color of the back button title
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        }
    }
    private func fetchPreviousMessages(){
        viewModel.fetchMessagesByChatID(chatID: chatID, otherUserID: userID)
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
        if !self.viewModel.messages.isEmpty{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [weak self] in
                let lastMessageDate = self!.viewModel.datesArray.last!
                let lastMessageDateArrayCount = self!.viewModel.filteredMessages[lastMessageDate]!.count - 1
                
                self?.tableView.scrollToRow(at: IndexPath(row: lastMessageDateArrayCount , section: self!.viewModel.filteredMessages.count - 1), at: .bottom, animated: true)
            }
        }
    }
    @IBAction func sendMessageAction(){
        sendButton.showLoader()
        viewModel.request.text = tfMessage.text
        viewModel.request.recipientId = userID
        viewModel.sendMessage(chatID: chatID)
    }
    @objc func backBtnAction(){
        navigationController?.popViewController(animated: true)
    }

}
//MARK: UITableViewDelegate,UITableViewDataSource
extension SendMessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMessages[viewModel.datesArray[section]]?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.datesArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MessageDateView()
        headerView.setDate(date: viewModel.datesArray[section])
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let data = viewModel.messages[indexPath.row]
        let mDate = viewModel.datesArray[indexPath.section]
        let messages = viewModel.filteredMessages[mDate] ?? []
        let data = messages[indexPath.row]
        if data?.sender?.id == AuthManager.shared.getUserID(){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSentTVC") as? MessageSentTVC{
                cell.messageTV.text = data?.text ?? ""
                cell.timeLbl.text = CTAppearance.convertFrom(from: .dateZ, to: .standardTime, date: data?.timestamp ?? "")
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRecievedTVC") as? MessageRecievedTVC{
                cell.messageTV.text = data?.text ?? ""
                cell.timeLbl.text = CTAppearance.convertFrom(from: .dateZ, to: .standardTime, date: data?.timestamp ?? "")
                return cell
            }
        }
        return UITableViewCell()
    }
}
//MARK: ViewModel Delegate
extension SendMessageVC: DefaultViewModelDelegate{
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.sendButton.hideLoader()
            self?.tfMessage.text = ""
            self?.tableView.reloadData()
            let lastSection = (self?.viewModel.datesArray.count ?? 0) - 1
            let lastMessageDate = self?.viewModel.datesArray.last ?? Date()
            let lastSectionRow = (self?.viewModel.filteredMessages[lastMessageDate]?.count ?? 0) - 1
            self?.tableView.scrollToRow(at: IndexPath(row: lastSectionRow, section: lastSection), at: .bottom, animated: true)
        }
    }
    
    func failure(msg: String) {
        sendButton.hideLoader()
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
}
