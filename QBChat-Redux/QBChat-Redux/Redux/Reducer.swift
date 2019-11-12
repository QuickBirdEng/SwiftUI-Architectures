//
//  Reducer.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Combine
import Foundation

struct Reducer<State, Action> {
    typealias Change = (inout State) -> Void

    let reduce: (State, Action) -> AnyPublisher<Change, Never>
}

extension Reducer {
    static func sync(_ fun: @escaping (inout State) -> Void) -> AnyPublisher<Change, Never> {
        Just(fun).eraseToAnyPublisher()
    }
}
