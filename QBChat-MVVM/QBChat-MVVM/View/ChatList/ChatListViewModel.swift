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

    init(chatService: ChatService) {
        let viewModels = chatService.fetchChats().map {
            AnyViewModel(ChatDetailViewModel(chat: $0, chatService: chatService))
        }
        self.state = ChatListState(chats: viewModels)
    }

    func trigger(_ input: Never) {

    }

}
