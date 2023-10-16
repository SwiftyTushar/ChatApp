//
//  SocketManager.swift
//  ChatApp
//
//  Created by Tushar Patil on 22/09/23.
//
import Foundation
import SocketIO
import JavaScriptCore

class ChatSocketManager{
    static let shared = ChatSocketManager()
    
    private let manager = SocketManager(socketURL: URL(string: "http://localhost:3000/")!, config: [.log(true), .compress])
    private var socket:SocketIOClient?
    
    private init(){
        socket = manager.defaultSocket
        socket?.on("connect") { _, _ in
            print("Socket Connected")
        }
    }
    func establishSocketConnection(){
        socket?.connect()
    }
    func listenToChatUpdates(onReceive:@escaping ([String:Any]) -> Void){
        print("listenToChatUpdatesDESDOII=====")
        socket?.on("\(AuthManager.shared.getUserID()) chat updated", callback: { data, _ in
            print("listenToChatUpdates---- \(data)")
            let firstElement = data[0] as! String
            if let data = firstElement.data(using: .utf8){
                if let dictionary = try? JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]{
                    onReceive(dictionary)
                }
            }
            
        })
    }
    func listenToRecievedMessages(onReceive:@escaping(String) -> Void){
        socket?.on("\(AuthManager.shared.getUserID()) message recieved", callback: { data, _ in
            let firstElement = data[0] as! String
            print("TYPEODFDS---- \(firstElement)")
            if let data = firstElement.data(using: .utf8){
                if let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    onReceive(dictionary["chatID"] as? String ?? "")
                } else {
                    print("Recienefjewoiqjwojelse----")
                }
            }
            
            
            if let dataDict = data as? [[String:Any]]{
                onReceive(dataDict.first?["chatID"] as? String ?? "")
            } else {
                print("Recienved msg but go nil data")
            }
        })
    }
    func emiteMessageSent(recieverID:String,message:String,chatID:String){
        let dictionary = ["senderID":AuthManager.shared.getUserID(),"receiverID":recieverID,"message":message,"chatID":chatID]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []){
            let jsonStr = String(data: jsonData, encoding: .utf8)!
            socket?.emit("new message", with: [jsonStr])
        }
        
    }
}



