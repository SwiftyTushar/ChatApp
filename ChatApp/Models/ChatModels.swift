//
//  ChatModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 02/10/23.
//

import Foundation

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
    let v: Int?
    var userName,otherUserID:String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case users, messages, latestMessage,userName,otherUserID,lastText

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
