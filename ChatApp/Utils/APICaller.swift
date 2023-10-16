//
//  APICaller.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import Foundation

enum URLType:String{
    case login = "auth/login"
    case signup = "auth/signup"
    case search = "api/users/search?query="
    case chats = "chats/"
    case fetchChatMessages = "chats/fetch/messages"
    case message = "messages"
    case sendMessage = "message/send-message"
}
enum HTTPMethod:String{
    case get = "get"
    case post = "post"
    case delete = "delete"
    case put = "put"
    case patch = "patch"
}
fileprivate let urlNotFoundError = "URL Not found!"

class APICaller{
    private init(){}
    static let shared = APICaller()
    private let baseURL = "http://localhost:3000/"
    func request<T:Encodable,U:Decodable>(
        url:URLType,
        method:HTTPMethod,
        body:T,
        authNeeded:Bool = false,
        query:String = "",
        responseType:U.Type,
        completion:@escaping((U?,String?) -> Void)
    ){
        var mURL = url.rawValue
        print("QUERY--- \(query)")
        if !query.isEmpty{
            mURL += query
        }
        print("MYURLSEDJWOI---- \(baseURL + mURL)")
        guard let url = URL(string: baseURL + mURL) else {completion(nil,urlNotFoundError); return}
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 6.0
        request.httpMethod = method.rawValue.uppercased()
        print("=====URL======")
        print(url.absoluteString)
        print("=====Body======")
        print(body)
        let encodedData = try? JSONEncoder().encode(body)
        print("encodedData---- \(encodedData)")
        if method != .get{
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = encodedData
        }
        if authNeeded{
            request.setValue("Bearer \(AuthManager.shared.getToken())", forHTTPHeaderField: "Authorization")
        }
        print("======HEADERS=====")
        print(request.allHTTPHeaderFields ?? [:])
        URLSession.shared.dataTask(with: request) { resData, response, error in
            print("====Response====")
            print(response)
            if let data = resData{
                let decoded = try? JSONDecoder().decode(responseType.self, from: data)
                print("==== Decoded Response =====")
                print(decoded)
                
                completion(decoded,nil)
            } else {
                if error != nil{
                    completion(nil,error?.localizedDescription)
                }
            }
        }.resume()
        
    }
}
