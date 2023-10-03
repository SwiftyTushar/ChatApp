//
//  MessageModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

struct ChatMessagesResponse: Codable {
    let messages: [Message?]
}

// MARK: - Message
struct Message: Codable {
    let id, text: String?
    let sender, recipient: Recipient?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text, sender, recipient, timestamp
    }
}

// MARK: - Recipient
struct Recipient: Codable {
    let id, username: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
    }
}
//MARK: SendMessageRequest
struct SendMessageRequest: Encodable{
    var senderId,recipientId,text:String?
}
//MARK: SendMessageResponse
struct SendMessageResponse: Decodable{
    var message:String?
    var chatID:String?
}
