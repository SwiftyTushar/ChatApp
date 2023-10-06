//
//  SearchResponse.swift
//  ChatApp
//
//  Created by Tushar Patil on 03/10/23.
//

import Foundation

struct SearchResponse: Decodable {
    let users: [User?]
}
struct User: Decodable {
    let id, username, password, email: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, password, email
    }
}
