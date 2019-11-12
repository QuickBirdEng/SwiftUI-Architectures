//
//  AppAction.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

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
