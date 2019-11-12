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

    @ObservedObject
    var keyboardObserver = KeyboardObserver.shared

    @State
    private var newMessage = ""

    var messages: [Message] {
        chatService.fetchMessages().filter { $0.chatId == chat.id }
    }

    var body: some View {
        VStack {
            List(messages) { message in
                MessageView(message: message,
                            isMine: self.chatService.currentUser == message.sender)
            }
            .onTapGesture { self.endEditing(force: true) }

            Divider()

            HStack {
                TextField(newMessage.isEmpty ? "New message" : newMessage,
                          // This is because we need to update the UI because of a state change
                          text: $newMessage,
                          onCommit: sendMessage)

                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding([.leading, .top, .trailing])
        }
        .padding(.bottom, keyboardObserver.height)
        .navigationBarTitle(Text(chat.title), displayMode: .inline)
        .animation(.easeInOut)
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        chatService.addMessage(newMessage, to: chat)
        newMessage = ""
    }

    private func endEditing(force: Bool) {
        UIApplication.shared.windows
            .forEach { $0.endEditing(force) }
    }

}
