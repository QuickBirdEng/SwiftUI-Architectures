//
//  ChatListView.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatListState {
    var chats: [AnyViewModel<ChatDetailState, ChatDetailInput>]
}

extension ChatDetailState: Identifiable {
    var id: Chat.ID {
        chat.id
    }
}

struct ChatListView: View {

    @EnvironmentObject
    var viewModel: AnyViewModel<ChatListState, Never>

    var body: some View {
        NavigationView {
            List(viewModel.chats) { viewModel in
                NavigationLink(destination: ChatDetailView()
                    .environmentObject(viewModel)
                    .environmentObject(KeyboardObserver.shared)) {
                        ChatCell(chat: viewModel.state.chat)
                }
            }
            .navigationBarTitle("Chats")
        }
    }

}
