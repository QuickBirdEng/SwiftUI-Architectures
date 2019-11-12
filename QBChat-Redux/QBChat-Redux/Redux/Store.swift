//
//  Store.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Combine
import Foundation

final class Store<State, Action>: ObservableObject {

    // MARK: Stored properties

    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []

    // MARK: Initialization

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    // MARK: Methods

    func send(_ action: Action) {
        reducer
            .reduce(state, action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: perform)
            .store(in: &cancellables)
    }

    // MARK: Helpers

    private func perform(change: Reducer<State, Action>.Change) {
        change(&state)
    }

}
