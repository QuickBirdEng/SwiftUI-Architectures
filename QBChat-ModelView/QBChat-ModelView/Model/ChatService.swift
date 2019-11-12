//
//  ChatService.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

protocol ChatService {
    var currentUser: String? { get }
    func fetchChats() -> [Chat]
    func fetchMessages() -> [Message]

    @discardableResult
    func addMessage(_ content: String, to chat: Chat) -> Message
}
