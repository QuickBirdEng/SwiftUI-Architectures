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

    @EnvironmentObject
    private var keyboardObserver: KeyboardObserver

    @State
    private var newMessage = ""

    init(chat: Chat) {
        self.chat = chat
    }

    var body: some View {
        VStack {
            List(store.state.messages(in: chat)) { message in
                MessageView(message: message,
                            isMine: self.store.state.currentUser == message.sender)
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
        .navigationBarTitle(Text(chat.title), displayMode: .inline)
        .animation(.easeInOut)
    }

}

// MARK: - Private Helper

extension ChatDetailView {

    private func sendMessage() {
        store.send(.chatDetail(.add(newMessage, to: chat)))
        newMessage = ""
    }

    private func endEditing(force: Bool) {
        UIApplication.shared.windows
            .forEach { $0.endEditing(force) }
    }

}
