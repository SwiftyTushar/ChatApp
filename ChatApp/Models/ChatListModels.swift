//
//  ChatListModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 17/09/23.
//

import Foundation

struct ChatListResponse: Decodable {
    let status: Bool?
    let statusCode: Int?
    let data: [ChatData]?
}
struct ChatData: Decodable{
    let id, chatName: String?
        let isGroupChat: Bool?
        let users: [ChatUser]?
        let createdAt, updatedAt: String?
        let v: Int?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case chatName, isGroupChat, users, createdAt, updatedAt
            case v = "__v"
        }
}
struct ChatUser: Decodable{
    let id, name, email: String
    let pic: String
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, pic, createdAt, updatedAt
        case v = "__v"
    }
}
