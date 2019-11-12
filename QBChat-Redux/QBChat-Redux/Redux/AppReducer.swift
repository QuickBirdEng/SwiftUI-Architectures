//
//  AppReducer.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let chatService: ChatService = MockChatService()

        return Reducer { state, action in
            switch action {
            case .chatDetail(let action):
                handleChatDetailAction(action, chatService: chatService)
            case .chatList(let action):
                handleChatListAction(action)
            }

            return Reducer.sync { state in
                state.currentUser = chatService.currentUser
                state.chats = chatService.fetchChats()
                state.messages = chatService.fetchMessages()
            }
        }
    }

    private static func handleChatListAction(_ action: ChatListAction) {
        switch action {
        case .reload:
            break
        }
    }

    private static func handleChatDetailAction(_ action: ChatDetailAction, chatService: ChatService) {
        switch action {
        case .reload:
            break
        case let .add(content, chat):
            chatService.addMessage(content, to: chat)
        }
    }

}
