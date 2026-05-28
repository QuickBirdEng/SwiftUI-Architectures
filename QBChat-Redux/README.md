# QBChat — Redux

A single global `Store<AppState, AppAction>` holds the app's entire state. Views read it via `@EnvironmentObject` and dispatch `Action` values through `store.send(_:)`. A single root `appReducer` interprets each action — possibly running async side effects against `ChatService` — and produces a deferred `Change` closure that is applied to `state` on the main actor.

Note: in this implementation the canonical state lives in `MockChatService`. The reducer re-derives the whole `AppState` from the service after every action, so `AppState` is best understood as a SwiftUI-friendly cache of the service. This keeps the teaching example small, but it's the part you'd replace first in a real Redux app.

> For production SwiftUI Redux, see [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture). This implementation is a minimal hand-roll intended for teaching.

## Read these files in order

1. [`QBChat-Redux/Common/QBChatApp.swift`](QBChat-Redux/Common/QBChatApp.swift) — entry point. Builds the root `Store` and injects it via `.environmentObject`.
2. [`QBChat-Redux/Redux/Store.swift`](QBChat-Redux/Redux/Store.swift) — the dispatch + observation loop.
3. [`QBChat-Redux/Redux/Reducer.swift`](QBChat-Redux/Redux/Reducer.swift) — the `(State, Action) async -> Change` shape.
4. [`QBChat-Redux/Redux/AppState.swift`](QBChat-Redux/Redux/AppState.swift) — the global state struct.
5. [`QBChat-Redux/Redux/AppAction.swift`](QBChat-Redux/Redux/AppAction.swift) — the nested action hierarchy.
6. [`QBChat-Redux/Redux/AppReducer.swift`](QBChat-Redux/Redux/AppReducer.swift) — the root reducer; note how it runs side effects and re-derives `AppState`.
7. [`QBChat-Redux/Scenes/ChatListView.swift`](QBChat-Redux/Scenes/ChatListView.swift) — first view consuming the store.
8. [`QBChat-Redux/Scenes/ChatDetailView.swift`](QBChat-Redux/Scenes/ChatDetailView.swift) — same, with a dispatching `Send` button.
