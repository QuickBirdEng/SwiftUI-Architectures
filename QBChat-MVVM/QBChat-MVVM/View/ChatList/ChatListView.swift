//
//  ChatListView.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

/// State rendered by `ChatListView`. `chats` is the array of type-erased
/// detail view models — the list view model owns the lifetime of each detail
/// view model, so navigating in and out of a chat preserves its state.
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
        NavigationStack {
            List(viewModel.chats) { viewModel in
                NavigationLink(destination: ChatDetailView().environmentObject(viewModel)) {
                    ChatCell(chat: viewModel.state.chat)
                }
            }
            .navigationTitle("Chats")
        }
    }

}
