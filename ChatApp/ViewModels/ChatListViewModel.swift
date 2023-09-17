//
//  ChatListViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 17/09/23.
//

import Foundation

class ChatListViewModel{
    
    var chats:[ChatData] = []
    
    func fetchChats(completion:@escaping(Bool) -> Void){
        
        APICaller.shared.request(url: .getChats, method: .get, body: EmptyRequest(),authNeeded: true, responseType: ChatListResponse.self) {[weak self] response, error in
            if error != nil{
                Alert.shared.showAlertWithOkBtn(title: "Error", message: error ?? "")
                completion(false)
            } else {
                if response?.status == true{
                    self?.chats = response?.data ?? []
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        
    }
}
