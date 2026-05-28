//
//  Store.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

/// The single source of truth for the Redux variant.
///
/// Views observe `state` via `@Published`; they trigger transitions by calling
/// `send(_:)` with an `Action`. The `Reducer` may run async work and ultimately
/// produces a `Change` that is applied to `state` on the main actor — that
/// single write site is what makes the publish/observe story predictable.
final class Store<State, Action>: ObservableObject {

    // MARK: Stored properties

    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    // MARK: Initialization

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    // MARK: Methods

    /// Dispatches an `Action`. The reducer runs (potentially async), then the
    /// resulting `Change` is applied to `state` on the main actor.
    func send(_ action: Action) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let change = await self.reducer.reduce(self.state, action)
            change(&self.state)
        }
    }

}
