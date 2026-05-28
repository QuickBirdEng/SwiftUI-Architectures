//
//  ChatListView.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatListView: View {
    let chatService: ChatService

    @State private var chats: [Chat] = []

    var body: some View {
        NavigationStack {
            List(chats) { chat in
                NavigationLink(
                    destination: ChatDetailView(chat: chat,
                                                chatService: chatService)
                ) {
                    ChatCell(chat: chat)
                }
            }
            .navigationTitle("Chats")
        }
        .task {
            chats = await chatService.fetchChats()
        }
    }

}
