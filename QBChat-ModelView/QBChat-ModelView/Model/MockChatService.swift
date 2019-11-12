//
//  MockChatService.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

class MockChatService: ChatService {

    let currentUser: String? = "You"

    private let chats = [
        Chat(id: "1", title: "Party on Sunday", subtitle: "Lukas: How about going to that new bar?"),
        Chat(id: "2", title: "Lisa Simpson", subtitle: "Lisa: Hey!"),
        Chat(id: "3", title: "Salvador Dali", subtitle: "You: I love your new painting!"),
        Chat(id: "4", title: "Tim Apple", subtitle: "Tim: My name is Tim Cook?!"),
        Chat(id: "5", title: "Stefan Kofler", subtitle: "Stefan: There is a new project coming up..."),
        Chat(id: "6", title: "Gift for Noah", subtitle: "Peter: Hey guys! Do you have an idea what we can give Noah as a gift for his birthday?"),
    ]

    private var messages = [
        Message(id: UUID().uuidString, chatId: "2", date: Date(), sender: "Lisa", content: "Hey!"),
        Message(id: UUID().uuidString, chatId: "1", date: Date(), sender: "Lukas", content: "How about going to that new bar?"),
        Message(id: UUID().uuidString, chatId: "3", date: Date(), sender: "You", content: "I love your new painting!"),
        Message(id: UUID().uuidString, chatId: "4", date: Date(), sender: "You", content: "Hey Tim Apple! What's up?"),
        Message(id: UUID().uuidString, chatId: "4", date: Date(), sender: "Tim", content: "My name is Tim Cook?!"),
        Message(id: UUID().uuidString, chatId: "5", date: Date(), sender: "Stefan", content: "There is a new project coming up..."),
        Message(id: UUID().uuidString, chatId: "6", date: Date(), sender: "Peter", content: "Hey guys! Do you have an idea what we can give Noah as a gift for his birthday?")
    ]

    func fetchChats() -> [Chat] {
        chats
    }

    func fetchMessages() -> [Message] {
        messages
    }

    func addMessage(_ content: String, to chat: Chat) -> Message {
        let message = Message(id: UUID().uuidString,
                              chatId: chat.id,
                              date: Date(),
                              sender: currentUser ?? "",
                              content: content)
        messages.append(message)
        return message
    }
}
