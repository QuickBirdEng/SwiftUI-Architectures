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

    var body: some View {
        NavigationView {
            List(chatService.fetchChats()) { chat in
                NavigationLink(
                    destination: ChatDetailView(chat: chat,
                                                chatService: self.chatService)
                ) {
                    ChatCell(chat: chat)
                }
            }
            .navigationBarTitle("Chats")
        }
    }

}
