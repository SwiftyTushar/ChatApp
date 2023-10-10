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
                    self?.delegate?.success()
                }
            }
        }
    }
    private func filterMessages(){
        guard !messages.isEmpty else {return}
        datesArray.removeAll()
        
        var previousDate = CTAppearance.getDate(from: messages[0]?.timestamp ?? "")
        filteredMessages[previousDate] = []
        datesArray.append(previousDate)
        
        for message in messages {
            let messageDate = CTAppearance.getDate(from: message?.timestamp ?? "")
            if !CTAppearance.compareDates(firstDate: messageDate, secondDate: previousDate){
                previousDate = messageDate
                datesArray.append(previousDate)
            }
            if filteredMessages[previousDate] == nil{
                datesArray.append(previousDate)
                filteredMessages[previousDate] = []
            } else {
                filteredMessages[previousDate]?.append(message)
            }
        }
        print("filterMessagese----- \(filteredMessages)")
    }
}
