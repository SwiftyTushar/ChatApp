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
    var filteredMessages:[Date:[Message?]] = [:]
    var datesArray:[Date] = []
    
    init() {
        ChatSocketManager.shared.listenToRecievedMessages {[weak self] data in
            print("MessageViewModel.self------- \(data)")
            
            self?.fetchMessages(chatID: data)
        }
    }
    
    func sendMessage(chatID:String){
        request.senderId = AuthManager.shared.getUserID()
        APICaller.shared.request(url: .sendMessage, method: .post, body: request, responseType: SendMessageResponse.self) { [weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                ChatSocketManager.shared.emiteMessageSent(recieverID: self?.request.recipientId ?? "",message: self?.request.text ?? "",chatID: chatID)
                self?.fetchMessages(chatID: response?.chatID ?? "")
            }
        }
    }
    func fetchMessagesByChatID(chatID:String,otherUserID:String){
        let request = FetchChatsRequest(chatID: chatID,currentUserID: AuthManager.shared.getUserID(), recipientID: otherUserID)
        APICaller.shared.request(url: .fetchChatMessages, method: .post, body: request, responseType: ChatMessagesResponse.self) {[weak self] response, error in
            if error != nil{
                self?.delegate?.failure(msg: error ?? "")
            } else {
                if let response = response{
                    self?.messages.removeAll()
                    self?.messages = response.messages
                    self?.filterMessages()
                }
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
                    self?.filterMessages()
                }
            }
        }
    }
    private func filterMessages(){
        guard !messages.isEmpty else {return}
        filteredMessages = [:]
        datesArray.removeAll()
        
        var previousDate = CTAppearance.getDate(from: messages[0]?.timestamp ?? "")
        filteredMessages[previousDate] = []
        datesArray.append(previousDate)
        
        for message in messages {
            
            let messageDate = CTAppearance.getDate(from: message?.timestamp ?? "")
            print("MessageGOTITO--- \(message?.text ?? "nil") date \(messageDate) result \(CTAppearance.compareDates(firstDate: messageDate, secondDate: previousDate))")
            
            if !CTAppearance.compareDates(firstDate: messageDate, secondDate: previousDate){
                print("MessageGOTITO---For ---- \(message?.text ?? "nil")")
                previousDate = messageDate
                if filteredMessages[previousDate] == nil{
                    filteredMessages[previousDate] = []
                    datesArray.append(previousDate)
                }
                filteredMessages[previousDate]?.append(message)
            } else {
                if filteredMessages[previousDate] == nil{
                    filteredMessages[previousDate] = []
                    datesArray.append(previousDate)
                }
                filteredMessages[previousDate]?.append(message)
            }
        }
        delegate?.success()
        print("filterMessagese----- \(datesArray.count)")
    }
}
