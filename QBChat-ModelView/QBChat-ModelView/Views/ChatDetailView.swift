//
//  ChatDetailView.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatDetailView: View {

    let chat: Chat

    let chatService: ChatService

    @State private var messages: [Message] = []

    @State private var newMessage = ""

    @FocusState private var inputFocused: Bool

    var body: some View {
        VStack {
            List(messages) { message in
                MessageView(message: message,
                            isMine: chatService.currentUser == message.sender)
            }
            .onTapGesture { inputFocused = false }

            Divider()

            HStack {
                TextField("New message", text: $newMessage)
                    .focused($inputFocused)
                    .onSubmit(sendMessage)

                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding([.leading, .top, .trailing])
        }
        .navigationTitle(chat.title)
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: messages.count)
        .task(id: chat.id) {
            await reloadMessages()
        }
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        let content = newMessage
        newMessage = ""
        Task {
            await chatService.addMessage(content, to: chat)
            await reloadMessages()
        }
    }

    private func reloadMessages() async {
        messages = await chatService.fetchMessages()
            .filter { $0.chatId == chat.id }
    }

}
