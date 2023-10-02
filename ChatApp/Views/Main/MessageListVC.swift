//
//  MessageListVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 10/09/23.
//

import UIKit
import SDWebImage

class MessageListVC: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
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
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SendMessageVC") as! SendMessageVC
        vc.chatID = viewModel.chats[indexPath.row]?.id ?? ""
        //vc.chatID = viewModel.chats[indexPath.row].id ?? ""
        tabBarController?.tabBar.isHidden = true
        vc.title = viewModel.chats[indexPath.row]?.userName ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
//MARK: ViewModelDelegate
extension MessageListVC: DefaultViewModelDelegate{
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failure(msg: String) {
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
    
}
