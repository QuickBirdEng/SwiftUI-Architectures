//
//  ChatListView.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatListView: View {

    @EnvironmentObject
    private var store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            List(store.state.chats) { chat in
                NavigationLink(destination: ChatDetailView(chat: chat)) {
                    ChatCell(chat: chat)
                }
            }
            .navigationBarTitle("Chats")
        }
        .onAppear { self.store.send(.chatList(.reload)) }
    }

}
