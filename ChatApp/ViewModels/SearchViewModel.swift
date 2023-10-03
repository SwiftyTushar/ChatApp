//
//  SearchViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 03/10/23.
//

import Foundation

class SearchViewModel{
    var delegate:DefaultViewModelDelegate?
    var users:[User?] = []
    
    func search(query:String){
        APICaller.shared.request(url: .search, method: .get, body: EmptyRequestBody.init(),query: query, responseType: SearchResponse.self) {[weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    self?.users = response.users.filter({ user in
                        return user?.id != AuthManager.shared.getUserID()
                    })
                }
                self?.delegate?.success()
            }
        }
    }
}
