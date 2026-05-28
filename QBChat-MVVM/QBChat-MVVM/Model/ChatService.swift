//
//  ChatService.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

/// The side-effect seam every architecture in this repo sits on top of.
///
/// All three variants (Model-View, Redux, ViewState MVVM) consume the same
/// `ChatService` protocol. What differs between them is *where* and *how* the
/// results of these methods are stored and exposed to views.
protocol ChatService {
    var currentUser: String? { get }
    func fetchChats() async -> [Chat]
    func fetchMessages() async -> [Message]

    @discardableResult
    func addMessage(_ content: String, to chat: Chat) async -> Message
}
