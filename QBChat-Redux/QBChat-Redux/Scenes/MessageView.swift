//
//  MessageView.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    let isMine: Bool

    var body: some View {
        VStack(alignment: isMine ? .trailing : .leading, spacing: 2) {
            Text(message.sender)
                .font(.footnote)
                .foregroundColor(Color.gray)

            HStack {
                Spacer().frame(height: 0)
            }

            Text(message.content)
                .lineLimit(nil)
                .padding(8)
                .font(.body)
                .background(textBackgroundColor)
                .cornerRadius(8)
        }
    }

    private var textBackgroundColor: Color {
        guard !isMine else { return .green }
        switch abs(message.sender.hashValue % 5) {
        case 0:
            return .yellow
        case 1:
            return .blue
        case 2:
            return .orange
        case 3:
            return .pink
        case 4:
            return .purple
        default:
            assertionFailure()
            return .red
        }
    }
}
