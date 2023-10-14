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

    init() {
        ChatSocketManager.shared.listenToChatUpdates { dictionary in
            self.fetchChats(sortWith: dictionary["chatID"] as? String ?? "")
        }
    }
    
    func fetchChats(sortWith:String = ""){
        let currentUserID = AuthManager.shared.getUserID()
        APICaller.shared.request(url: .chats, method: .get, body: EmptyRequestBody.init(),query: "\(currentUserID)", responseType: ChatResponse.self) {[weak self] response, error in
            self?.chats.removeAll()
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    for chat in response.userChats{
                        var chatModel = chat
                        chatModel?.date = CTAppearance.getDate(from: chat?.lastMessageTime ?? "")
                        print("GETIME---- \(CTAppearance.convertFrom(from: .dateZ, to: .standardTime, date: chatModel?.lastMessageTime ?? ""))")
                        for user in chat?.users ?? []{
                            if user.id != AuthManager.shared.getUserID(){
                                chatModel?.userName = user.username
                                chatModel?.otherUserID = user.id
                                self?.chats.append(chatModel)
                            }
                        }
                    }
                    if !sortWith.isEmpty{
                        for (index,chat) in (self?.chats ?? []).enumerated() {
                            if sortWith == chat?.id{
                                self?.chats.swapAt(0, index)
                                break
                            }
                        }
                    }
                    self?.delegate?.success()
                }
            }
        }
    }
}
