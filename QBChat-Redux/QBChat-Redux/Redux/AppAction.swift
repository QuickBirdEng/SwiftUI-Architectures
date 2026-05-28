//
//  AppAction.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

/// Top-level action dispatched into `Store<AppState, AppAction>`.
///
/// Actions are nested per scene so the root reducer can compose smaller
/// per-scene handlers while the store still has a single root `Action` type.
enum AppAction {
    case chatList(ChatListAction)
    case chatDetail(ChatDetailAction)
}

enum ChatListAction {
    case reload
}

enum ChatDetailAction {
    case reload
    case add(String, to: Chat)
}
