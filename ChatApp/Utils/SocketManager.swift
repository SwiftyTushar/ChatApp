//
//  SocketManager.swift
//  ChatApp
//
//  Created by Tushar Patil on 22/09/23.
//
import Foundation

class SocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    static let shared = SocketManager()
    
    init() {
        connectToSocketServer()
    }
    
    
    private func connectToSocketServer() {
        guard let url = URL(string: "http://13.126.127.141/api/message/") else {
            print("Invalid URL")
            return
        }

        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)

        webSocketTask?.resume()

        receiveMessages()
    }

    func send(message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket send error: \(error)")
            }
        }
    }

    func receiveMessages() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket receive error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    // Handle received text message (e.g., JSON parsing)
                    print("Received message: \(text)")
                default:
                    break
                }
                self?.receiveMessages() // Continue listening for messages
            }
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}



