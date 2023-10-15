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
    private var totalNumberOfPendingMessages = 0
    
    var recievedNewMessage:((String) -> Void)?
    
    init() {
        ChatSocketManager.shared.listenToChatUpdates { dictionary in
            self.totalNumberOfPendingMessages += 1
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
                        print("misoqwer--- \(chat?.lastMessageTime ?? 0.0)")
                        chatModel?.messageDate = Date(timeIntervalSince1970: (chat?.lastMessageTime ?? 0.0) / 1000.0)
                        for user in chat?.users ?? []{
                            if user.id != AuthManager.shared.getUserID(){
                                chatModel?.userName = user.username
                                chatModel?.otherUserID = user.id
                                self?.chats.append(chatModel)
                            }
                        }
                    }
                    self?.chats.sort(by: { firstChat, secondChat in
                        let firstMS = firstChat?.lastMessageTime ?? 0.0
                        let secondMS = secondChat?.lastMessageTime ?? 0.0
                        return firstMS > secondMS
                    })
                    self?.delegate?.success()
                }
            }
        }
    }
}
