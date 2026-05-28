//
//  QBChatApp.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

@main
struct QBChatApp: App {
    @StateObject private var viewModel = AnyViewModel(
        ChatListViewModel(chatService: MockChatService())
    )

    var body: some Scene {
        WindowGroup {
            ChatListView()
                .environmentObject(viewModel)
        }
    }
}
