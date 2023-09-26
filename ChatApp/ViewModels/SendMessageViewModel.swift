//
//  SendMessageViewModel.swift
//  ChatApp
//
//  Created by Tushar Patil on 26/09/23.
//

import Foundation

protocol SendMessageViewModelDelegate{
    func success()
    func failure(msg:String)
}

class SendMessageViewModel{
    
    var delegate:SendMessageViewModelDelegate?
    var messages:[Message] = []
    
    func fetchMessages(chatID:String){
        APICaller.shared.request(url: .message, method: .get, body: EmptyRequest.init(),authNeeded: true,query: "/\(chatID)", responseType: GetMessagesResponse.self) {[weak self] decodable, msg in
            if msg != nil{
                self?.delegate?.failure(msg: msg ?? "")
            } else {
                self?.messages = decodable?.data ?? []
                self?.delegate?.success()
            }
        }
        
    }
}
