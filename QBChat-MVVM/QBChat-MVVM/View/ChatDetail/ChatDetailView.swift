//
//  ChatDetailView.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

/// Read-only snapshot the chat detail view renders.
struct ChatDetailState {
    var chat: Chat
    var currentUser: String?
    var messages: [Message]
}

/// The closed set of user-driven events `ChatDetailView` can request.
enum ChatDetailInput {
    case addMessage(String)
}

struct ChatDetailView: View {

    @EnvironmentObject
    private var viewModel: AnyViewModel<ChatDetailState, ChatDetailInput>

    @State
    private var newMessage = ""

    @FocusState
    private var inputFocused: Bool

    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                MessageView(message: message,
                            isMine: viewModel.currentUser == message.sender)
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
        .navigationTitle(viewModel.chat.title)
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: viewModel.messages.count)
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        viewModel.trigger(.addMessage(newMessage))
        newMessage = ""
    }

}
