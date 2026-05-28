//
//  ChatListViewModel.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

class ChatListViewModel: ViewModel {

    @Published
    var state: ChatListState

    private let chatService: ChatService

    init(chatService: ChatService) {
        self.chatService = chatService
        self.state = ChatListState(chats: [])
        Task { @MainActor [weak self] in
            await self?.load()
        }
    }

    /// `Never` as the `Input` type statically encodes "this view model accepts
    /// no user-driven inputs" — there is no call site that can pass anything.
    func trigger(_ input: Never) {}

    @MainActor
    private func load() async {
        let chats = await chatService.fetchChats()
        state = ChatListState(chats: chats.map {
            AnyViewModel(ChatDetailViewModel(chat: $0, chatService: chatService))
        })
    }

}
