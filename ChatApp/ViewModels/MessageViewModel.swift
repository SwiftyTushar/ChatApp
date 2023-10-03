//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

class MessageViewModel{
    var delegate:DefaultViewModelDelegate?
    var messages:[Message?] = []
    var request = SendMessageRequest()
    
    func sendMessage(chatID:String){
        request.senderId = AuthManager.shared.getUserID()
        APICaller.shared.request(url: .sendMessage, method: .post, body: request, responseType: SendMessageResponse.self) { [weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                self?.fetchMessages(chatID: response?.chatID ?? "")
            }
        }
    }
    
    func fetchMessages(chatID:String){
        APICaller.shared.request(
            url: .chats,
            method: .get,
            body: EmptyRequestBody.init(),
            query: "\(chatID)/messages",
            responseType: ChatMessagesResponse.self) {[weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    self?.messages.removeAll()
                    self?.messages = response.messages
                    self?.delegate?.success()
                }
            }
        }
    }
}