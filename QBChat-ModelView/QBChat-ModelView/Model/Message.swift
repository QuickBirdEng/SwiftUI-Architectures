//
//  Message.swift
//  QBChat-ModelView
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: String
    var chatId: String
    var date: Date
    var sender: String
    var content: String
}
