//
//  ChatDetailView.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatDetailState {
    var chat: Chat
    var currentUser: String?
    var messages: [Message]
}

enum ChatDetailInput {
    case addMessage(String)
}

struct ChatDetailView: View {

    @EnvironmentObject
    private var viewModel: AnyViewModel<ChatDetailState, ChatDetailInput>

    @EnvironmentObject
    private var keyboardObserver: KeyboardObserver

    @State
    private var newMessage = ""

    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                MessageView(message: message,
                            isMine: self.viewModel.currentUser == message.sender)
            }
            .onTapGesture { self.endEditing(force: true) }

            Divider()

            HStack {
                TextField("New message", text: $newMessage, onCommit: sendMessage)

                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding([.leading, .top, .trailing])
        }
        .padding(.bottom, keyboardObserver.height)
        .navigationBarTitle(Text(viewModel.chat.title), displayMode: .inline)
        .animation(.easeInOut)
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        viewModel.trigger(.addMessage(newMessage))
        newMessage = ""
    }

    private func endEditing(force: Bool) {
        UIApplication.shared.windows
            .forEach { $0.endEditing(force) }
    }

}
