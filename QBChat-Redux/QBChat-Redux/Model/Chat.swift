//
//  Chat.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

struct Chat: Codable, Identifiable {
    var id: String
    var title: String
    var subtitle: String
}
