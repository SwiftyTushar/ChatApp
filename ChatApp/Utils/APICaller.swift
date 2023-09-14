//
//  APICaller.swift
//  ChatApp
//
//  Created by Tushar Patil on 14/09/23.
//

import Foundation

enum URLType:String{
    case login = "user/login"
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
    private let baseURL = "http://13.126.127.141/api/"
    func request<T:Encodable,U:Decodable>(url:URLType,method:HTTPMethod,body:T,authNeeded:Bool = false,responseType:U.Type,completion:@escaping((U?,String?) -> Void)){
        
        guard let url = URL(string: baseURL + url.rawValue) else {completion(nil,urlNotFoundError); return}
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        print("=====URL======")
        print(url.absoluteString)
        print("=====Body======")
        print(body)
        let encodedData = try? JSONEncoder().encode(body)
        print("encodedData---- \(encodedData)")
        request.httpBody = encodedData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

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
