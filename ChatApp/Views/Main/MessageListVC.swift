//
//  MessageListVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/09/23.
//

import UIKit

class MessageListVC: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var placeHolder:PlaceholderView!
    
    private let viewModel = ChatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.setPlaceholderTextColorTo(color: .lightGray)
        searchBar.setTextColor(color: .white)
        tableView.register(UINib(nibName: "ChatUserTVC", bundle: nil), forCellReuseIdentifier: "ChatUserTVC")
        viewModel.delegate = self
        placeHolder.setTitleAndMessage(title: "No Chats found", message: "Search for other users and start the conversation")
        placeHolder.addCTAButton(with: "Search")
        placeHolder.buttonClicked = {
            self.tabBarController?.selectedIndex = 1
        }
//        viewModel.recievedNewMessage = { [weak self] pendingMessages in
//            DispatchQueue.main.async {
//                self?.navigationController?.tabBarItem.badgeValue = pendingMessages
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        viewModel.fetchChats()
    }
}
//MARK:
extension MessageListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUserTVC") as? ChatUserTVC{
            let data = viewModel.chats[indexPath.row]
            cell.usernameLbl.text = data?.userName
            cell.lastMsgLbl.text = data?.lastText
            cell.timeLbl.text = CTAppearance.getFormattedDates(date: data!.messageDate!)
//            cell.newMsgLbl.isHidden = (data?.isLatestMessageRead == true && data?.lastMessageSentBy == AuthManager.shared.getUserID())
            if data?.lastMessageSentBy == AuthManager.shared.getUserID(){
                cell.newMsgLbl.isHidden = true
            } else {
                cell.newMsgLbl.isHidden = data?.isLatestMessageRead == true
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SendMessageVC") as! SendMessageVC
        var data = viewModel.chats[indexPath.row]
        data?.isLatestMessageRead = true
        vc.chatID = data?.id ?? ""
        vc.userID = data?.otherUserID ?? ""
        vc.title = data?.userName ?? ""
        navigationController?.pushViewController(vc, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
//MARK: ViewModelDelegate
extension MessageListVC: DefaultViewModelDelegate{
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = self?.viewModel.chats.isEmpty ?? false
            self?.placeHolder.isHidden = !(self?.viewModel.chats.isEmpty ?? false)
            self?.tableView.reloadData()
        }
    }
    
    func failure(msg: String) {
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
    
}
