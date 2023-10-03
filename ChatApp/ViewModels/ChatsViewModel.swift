//
//  ChatsViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

class ChatsViewModel{
    var delegate: DefaultViewModelDelegate?
    var chats:[UserChat?] = []

    func fetchChats(){
        let currentUserID = AuthManager.shared.getUserID()
        APICaller.shared.request(url: .chats, method: .get, body: EmptyRequestBody.init(),query: "\(currentUserID)", responseType: ChatResponse.self) {[weak self] response, error in
            self?.chats.removeAll()
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    for chat in response.userChats{
                        var chatModel = chat
                        for user in chat?.users ?? []{
                            if user.id != AuthManager.shared.getUserID(){
                                chatModel?.userName = user.username
                                chatModel?.otherUserID = user.id
                                self?.chats.append(chatModel)
                            }
                        }
                    }
                    self?.delegate?.success()
                }
            }
        }
    }
}
