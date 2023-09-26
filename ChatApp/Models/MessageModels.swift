//
//  MessageModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 26/09/23.
//

import Foundation

struct GetMessagesResponse: Decodable{
    let status: Bool
    let statusCode: Int
    let data: [Message]?
}
//MARK: Message
struct Message: Codable {
    let id: String?
    let sender: Sender?
    let content: String?
    let chat: Chat?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender, content, chat, createdAt, updatedAt
        case v = "__v"
    }
}
// MARK: - Chat
struct Chat: Codable {
    let id, chatName: String?
    let isGroupChat: Bool?
    let users: [String]?
    let createdAt, updatedAt: String?
    let v: Int?
    let latestMessage: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case chatName, isGroupChat, users, createdAt, updatedAt
        case v = "__v"
        case latestMessage
    }
}
// MARK: - Sender
struct Sender: Codable {
    let id, name, email: String?
    let pic: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, pic
    }
}
