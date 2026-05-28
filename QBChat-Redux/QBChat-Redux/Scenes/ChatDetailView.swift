//
//  ChatDetailView.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatDetailView: View {

    private let chat: Chat

    @EnvironmentObject
    private var store: Store<AppState, AppAction>

    @State
    private var newMessage = ""

    @FocusState
    private var inputFocused: Bool

    init(chat: Chat) {
        self.chat = chat
    }

    var body: some View {
        VStack {
            List(store.state.messages(in: chat)) { message in
                MessageView(message: message,
                            isMine: store.state.currentUser == message.sender)
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
        .animation(.easeInOut, value: store.state.messages.count)
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        store.send(.chatDetail(.add(newMessage, to: chat)))
        newMessage = ""
    }

}
