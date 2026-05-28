//
//  Reducer.swift
//  QBChat-Redux
//
//  Created by Paul Kraft on 30.10.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation

/// A pure value that maps `(State, Action)` to a deferred state mutation.
///
/// Returning a `Change` closure rather than a new `State` is the central
/// trade-off of this Redux implementation: the reducer can run async side
/// effects to its heart's content, but the actual write to `State` is
/// funnelled through a single point in `Store`, so SwiftUI observers only
/// see one publish per dispatched action.
struct Reducer<State, Action> {
    /// An `inout` mutation that the store applies to its state on the main actor.
    typealias Change = (inout State) -> Void

    let reduce: (State, Action) async -> Change
}
