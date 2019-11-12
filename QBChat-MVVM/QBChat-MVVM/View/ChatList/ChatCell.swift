//
//  ChatCell.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct ChatCell: View {
    let chat: Chat

    var body: some View {
        VStack(alignment: .leading) {
            Text(chat.title)
                .font(.headline)

            Text(chat.subtitle)
                .font(.footnote)
                .foregroundColor(Color.gray)
        }
    }
}
