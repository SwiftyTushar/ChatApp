//
//  SearchViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 16/09/23.
//

import Foundation

class SearchViewModel{
    var searchResults:[UserData] = []
    func search(_ query:String,completion:@escaping(Bool) -> Void){
        APICaller.shared.request(url: .search, method: .get, body: EmptyRequest.init(),authNeeded: true,query: query, responseType: SearchResponse.self) {[weak self] response, error in
            if error != nil{
                completion(false)
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error ?? "")
            } else {
                self?.searchResults = response?.data ?? []
                completion(true)
            }
        }
    }
}
