//
//  AppState.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

struct AppState {
    var chats: [Chat] = []
    var messages: [Message] = []
    var currentUser: String? = nil

    func messages(in chat: Chat) -> [Message] {
        messages.filter { $0.chatId == chat.id }
    }
}
