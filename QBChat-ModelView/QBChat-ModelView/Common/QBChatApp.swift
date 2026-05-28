//
//  QBChatApp.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

@main
struct QBChatApp: App {
    private let chatService: ChatService = MockChatService()

    var body: some Scene {
        WindowGroup {
            ChatListView(chatService: chatService)
        }
    }
}
