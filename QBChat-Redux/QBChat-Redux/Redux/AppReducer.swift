//
//  AppReducer.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {

    /// The root reducer for the app.
    ///
    /// Note: the canonical state for chats and messages lives in `chatService`,
    /// not in `AppState`. Every action runs its side effect against the service
    /// and then re-derives the whole `AppState` from it — so `AppState` is best
    /// understood as a SwiftUI-friendly cache of the service.
    static func appReducer() -> Reducer {
        let chatService: ChatService = MockChatService()

        return Reducer { _, action in
            switch action {
            case .chatDetail(let action):
                await handleChatDetailAction(action, chatService: chatService)
            case .chatList(let action):
                handleChatListAction(action)
            }

            let chats = await chatService.fetchChats()
            let messages = await chatService.fetchMessages()
            let currentUser = chatService.currentUser

            return { state in
                state.currentUser = currentUser
                state.chats = chats
                state.messages = messages
            }
        }
    }

    private static func handleChatListAction(_ action: ChatListAction) {
        switch action {
        case .reload:
            break
        }
    }

    private static func handleChatDetailAction(_ action: ChatDetailAction, chatService: ChatService) async {
        switch action {
        case .reload:
            break
        case let .add(content, chat):
            await chatService.addMessage(content, to: chat)
        }
    }

}
