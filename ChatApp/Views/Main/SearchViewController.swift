//
//  SearchViewController.swift
//  ChatApp
//
//  Created by Tushar Patil on 15/09/23.
//

import UIKit
import Lottie

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var animationView:LottieAnimationView!
    @IBOutlet weak var animationParentVIew:UIView!
    private var debounceTimer:Timer?
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search..."
        searchBar.searchTextField.placeHolderColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.searchTextField.textColor = .black
        tableView.register(UINib(nibName: "ChatUserTVC", bundle: nil), forCellReuseIdentifier: "ChatUserTVC")
        animationView.play()
        animationView.loopMode = .autoReverse
        hidePlaceholderView()
        viewModel.delegate = self
    }
    private func showPlaceholderView(){
        tableView.isHidden = true
        animationParentVIew.isHidden = false
    }
    private func hidePlaceholderView(){
        tableView.isHidden = false
        animationParentVIew.isHidden = true
    }
    private func featchSearchResult(query:String){
        viewModel.search(query: query)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

}
//MARK: UITableViewDelegate,UITableViewDataSource
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.users[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUserTVC") as? ChatUserTVC{
            cell.lastMsgLbl.isHidden = true
            cell.timeLbl.isHidden = true
            cell.usernameLbl.text = user?.username
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.users[indexPath.row]
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SendMessageVC") as? SendMessageVC{
            vc.userID = data?.id ?? ""
            vc.title = data?.username
            navigationController?.pushViewController(vc, animated: true)
            tabBarController?.tabBar.isHidden = true
        }
    }
}
//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            self?.featchSearchResult(query: searchText)
        }
    }
}
//MARK: ViewModelDelegate
extension SearchViewController: DefaultViewModelDelegate{
    func success() {
        DispatchQueue.main.async { [weak self] in
            if self?.viewModel.users.isEmpty == true{
                self?.tableView.isHidden = true
                self?.animationParentVIew.isHidden = false
            } else {
                self?.tableView.isHidden = false
                self?.animationParentVIew.isHidden = true
            }
            self?.tableView.reloadData()
        }
    }
    
    func failure(msg: String) {
        Alert.shared.showAlertWithOkBtn(title: "Error", message: msg)
    }
}
