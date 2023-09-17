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
    private let viewModel = SearchViewModel()
    private var debounceTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search..."
        searchBar.searchTextField.placeHolderColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.textColor = .white
        tableView.register(UINib(nibName: "ChatUserTVC", bundle: nil), forCellReuseIdentifier: "ChatUserTVC")
        animationView.play()
        animationView.loopMode = .autoReverse
        hidePlaceholderView()
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
        viewModel.search(query) {[weak self] _ in
            DispatchQueue.main.async {
                if self?.viewModel.searchResults.isEmpty == true{
                    self?.showPlaceholderView()
                } else {
                    self?.showPlaceholderView()
                    self?.tableView.reloadData()
                }
                
            }
        }
    }

}
//MARK: UITableViewDelegate,UITableViewDataSource
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUserTVC") as? ChatUserTVC{
            cell.timeLbl.isHidden = true
            cell.usernameLbl.text = viewModel.searchResults[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
