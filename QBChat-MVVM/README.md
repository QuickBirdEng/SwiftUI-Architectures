# QBChat — ViewState MVVM

Each view depends on a per-view `ViewModel` exposing two things: a `State` (read-only snapshot the view renders) and an `Input` (closed set of user-driven events the view can request via `trigger(_:)`). A type-erased `AnyViewModel<State, Input>` wrapper lets views consume only that `(State, Input)` contract instead of a concrete implementation — making each view trivially mockable for tests and previews.

A view that accepts no user input declares `Input = Never` (see `ChatListViewModel`), and the compiler then statically prevents anyone from calling `trigger` on it.

This variant trades a bit more boilerplate (the protocol + the type eraser) for the cleanest contract surface of the three: a view's dependencies are exactly `(State, Input)`, fully visible at the call site.

## Read these files in order

1. [`QBChat-MVVM/Common/QBChatApp.swift`](QBChat-MVVM/Common/QBChatApp.swift) — entry point. Builds the root `ChatListViewModel`, wraps it in `AnyViewModel`, injects it.
2. [`QBChat-MVVM/MVVM/ViewModel.swift`](QBChat-MVVM/MVVM/ViewModel.swift) — the `ViewModel` protocol and the `AnyViewModel` type eraser. The architectural core.
3. [`QBChat-MVVM/View/ChatList/ChatListViewModel.swift`](QBChat-MVVM/View/ChatList/ChatListViewModel.swift) — a view model with `Input = Never`.
4. [`QBChat-MVVM/View/ChatList/ChatListView.swift`](QBChat-MVVM/View/ChatList/ChatListView.swift) — consumer using `@EnvironmentObject` and `@dynamicMemberLookup` (e.g. `viewModel.chats`).
5. [`QBChat-MVVM/View/ChatDetail/ChatDetailViewModel.swift`](QBChat-MVVM/View/ChatDetail/ChatDetailViewModel.swift) — a view model with a real `Input` enum.
6. [`QBChat-MVVM/View/ChatDetail/ChatDetailView.swift`](QBChat-MVVM/View/ChatDetail/ChatDetailView.swift) — dispatches inputs via `viewModel.trigger(.addMessage(...))`.
