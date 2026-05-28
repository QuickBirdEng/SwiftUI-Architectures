//
//  QBChatApp.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

@main
struct QBChatApp: App {
    @StateObject private var store = Store(initialState: AppState(),
                                           reducer: .appReducer())

    var body: some Scene {
        WindowGroup {
            ChatListView()
                .environmentObject(store)
        }
    }
}
