//
//  ViewModel.swift
//  QBChat-MVVM
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Combine
import Foundation

/// The shape every view model in this MVVM variant conforms to.
///
/// `State` is a read-only snapshot the view renders. `Input` is the closed set
/// of user-driven events the view can request — typically an `enum`, or
/// `Never` when the view model accepts no inputs at all. Splitting state and
/// input lets views depend on a small, type-safe contract instead of a
/// concrete observable object.
protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Input

    var state: State { get }
    func trigger(_ input: Input)
}

extension AnyViewModel: Identifiable where State: Identifiable {
    var id: State.ID {
        state.id
    }
}

/// Type-erased view model exposing only `(State, Input)` to its consumers.
///
/// SwiftUI's `@EnvironmentObject` / `@ObservedObject` require a concrete
/// `ObservableObject`. `AnyViewModel` erases the underlying view model's
/// concrete type so views depend on the `State`/`Input` contract, not the
/// implementation — making each view trivially mockable for tests and
/// previews.
///
/// `@dynamicMemberLookup` provides ergonomic, read-only access to fields of
/// the wrapped `State` (`viewModel.title` rather than `viewModel.state.title`)
/// without exposing a mutable property.
@dynamicMemberLookup
final class AnyViewModel<State, Input>: ViewModel {

    // MARK: Stored properties

    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void

    // MARK: Computed properties

    var objectWillChange: AnyPublisher<Void, Never> {
        wrappedObjectWillChange()
    }

    var state: State {
        wrappedState()
    }

    // MARK: Methods

    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }

    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }

    // MARK: Initialization

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Input == Input {
        self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }

}
