//
//  ChatModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

//MARK: FetchChatsRequest
struct FetchChatsRequest: Encodable{
    var chatID, currentUserID, recipientID: String?
    
    enum CodingKeys: String, CodingKey {
        case chatID, currentUserID
        case recipientID = "recipientId"
    }
}

//MARK: ChatResponse
struct ChatResponse: Codable {
    let userChats: [UserChat?]
}

// MARK: - UserChat
struct UserChat: Codable {
    let id: String?
    let users: [ChatUser]?
    let messages: [String]?
    let latestMessage: String?
    var lastText:String?
    var lastMessageTime:Double?
    let v: Int?
    var userName,otherUserID:String?
    var messageDate:Date?
    var isLatestMessageRead:Bool?
    var lastMessageSentBy:String?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case users, messages, latestMessage,userName,otherUserID,lastText,lastMessageTime,isLatestMessageRead, lastMessageSentBy

        case v = "__v"
    }
}

// MARK: - User
struct ChatUser: Codable {
    let id, username: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
    }
}
//MARK: EmptyRequestBody
struct EmptyRequestBody: Encodable{}
