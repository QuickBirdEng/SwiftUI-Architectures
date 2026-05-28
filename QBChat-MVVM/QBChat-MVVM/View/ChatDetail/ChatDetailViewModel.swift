//
//  ChatDetailViewModel.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

class ChatDetailViewModel: ViewModel {

    @Published
    private(set) var state: ChatDetailState

    private let chatService: ChatService

    private let chat: Chat

    init(chat: Chat, chatService: ChatService) {
        self.chatService = chatService
        self.chat = chat
        self.state = ChatDetailState(chat: chat,
                                     currentUser: chatService.currentUser,
                                     messages: [])
        Task { @MainActor [weak self] in
            await self?.reloadMessages()
        }
    }

    func trigger(_ input: ChatDetailInput) {
        switch input {
        case .addMessage(let message):
            Task { @MainActor [weak self] in
                guard let self else { return }
                await self.chatService.addMessage(message, to: self.chat)
                await self.reloadMessages()
            }
        }
    }

    @MainActor
    private func reloadMessages() async {
        state.messages = await chatService.fetchMessages()
            .filter { $0.chatId == chat.id }
    }

}
