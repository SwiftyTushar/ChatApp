//
//  SearchModels.swift
//  ChatApp
//
//  Created by Tushar Patil on 16/09/23.
//

import Foundation

struct SearchResponse:Decodable{
    let status:Bool?
    let data:[UserData]?
}
struct EmptyRequest: Encodable{
    
}
