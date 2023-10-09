//
//  PeopleYouMayKnowVC.swift
//  ChatApp
//
//  Created by Tushar Patil on 09/10/23.
//

import UIKit

class PeopleYouMayKnowVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ChatUserTVC", bundle: nil), forCellReuseIdentifier: "ChatUserTVC")
        viewModel.delegate = self
        viewModel.search(query: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func skipBtnAction(){
        NavigationHelper.rootToTabbar()
    }
}
//MARK: ViewModelDelegate
extension PeopleYouMayKnowVC: DefaultViewModelDelegate{
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failure(msg: String) {
        print("Failure-- \(msg)")
    }
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension PeopleYouMayKnowVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUserTVC") as? ChatUserTVC{
            cell.lastMsgLbl.text = "Tap to start a conversation"
            cell.timeLbl.text = ""
            cell.usernameLbl.text = viewModel.users[indexPath.row]?.username
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.users[indexPath.row]
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendMessageVC") as? SendMessageVC{
            vc.userID = data?.id ?? ""
            vc.title = data?.username
            navigationController?.pushViewController(vc, animated: true)
            tabBarController?.tabBar.isHidden = true
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
