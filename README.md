# SwiftUI Architectures: Model-View, Redux & ViewState MVVM

**QBChat** is the same minimal SwiftUI chat app built three times — once in plain Model-View, once with a Redux-style global store, and once with per-view MVVM. Open any of the three Xcode projects, hit Run, and read the same feature side-by-side across architectures to compare how state, side effects, and view bindings differ. Companion to [our blog post](https://quickbirdstudios.com/blog/swiftui-architecture-redux-mvvm/).

> **Status:** sample project. Last verified to build with Xcode 16 / iOS 16+ deployment target / Swift 5.

## At a glance

|                              | Model-View                          | Redux                                          | ViewState MVVM                                     |
| ---------------------------- | ----------------------------------- | ---------------------------------------------- | -------------------------------------------------- |
| **Where state lives**        | Inside views / service directly     | One global `Store<AppState>`                   | Per-view `ViewModel` (state + input)               |
| **How views trigger change** | Call service methods inline         | `store.send(.action)` → reducer                | `viewModel.trigger(.input)`                        |
| **View ↔ logic coupling**    | Tight                               | Loose, via actions                             | Loose, per-view contract                           |
| **Boilerplate**              | Lowest                              | Highest (actions, reducer, store)              | Medium (protocol + type erasure)                   |
| **Best fit**                 | Small apps, prototypes              | Large apps with shared state                   | Medium apps, testable views                        |
| **Key file to read first**   | `Views/ChatListView.swift`          | `Redux/AppReducer.swift`                       | `MVVM/ViewModel.swift`                             |

## Running it

Each variant is a standalone Xcode project (not a workspace) with no package manager dependencies. To run any of them:

1. Open `QBChat-<variant>/QBChat-<variant>.xcodeproj` in Xcode 16 or later.
2. Select an iOS 16+ simulator.
3. ⌘R.

## The three architectures

### Model-View

![](README/ModelView.jpeg)

Views call the `ChatService` directly and hold their own `@State`. There is no enforced separation between view code and business logic — similar in spirit to the MVC pattern with UIKit. See [`QBChat-ModelView/`](QBChat-ModelView/) for the full breakdown.

### Redux

![](README/Redux.jpeg)

A single global `Store<AppState, AppAction>` holds all state. Views dispatch `Action` values; a single `appReducer` runs side effects and produces deferred state mutations that are applied on the main actor. See [`QBChat-Redux/`](QBChat-Redux/) for the full breakdown.

> For production use, see [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) — the de-facto SwiftUI Redux library since 2020. This implementation is intentionally minimal for teaching.

### ViewState MVVM

![](README/MVVM.jpeg)

Each view depends on a per-view `ViewModel` exposing a `State` (snapshot to render) and an `Input` (closed set of user-driven events). A type-erased `AnyViewModel<State, Input>` wrapper lets views consume only that contract rather than a concrete implementation. See [`QBChat-MVVM/`](QBChat-MVVM/) for the full breakdown.

## Next steps / feature ideas

Pedagogically useful extensions — each one would illustrate a meaningfully different trade-off across the three architectures, and each is roughly a weekend of work:

- **Optimistic send with simulated delivery latency** — `addMessage` returns immediately as `.pending`, then flips to `.sent` (or `.failed`) after ~600 ms. The clearest demonstration of *where async state lives*: Model-View has to expose a stream, Redux gets a clean `.delivered(id)` action, MVVM owns the optimistic write inside the detail view model.
- **Per-chat draft persistence** — drafts in unsent messages survive navigating away and back. Forces each architecture to confront where view-local state belongs when it should outlive a single view instance.
- **Search-as-you-type chat filter** — a search field that filters the chat list. Showcases derived state, and in Redux exposes that the current reducer re-derives `chats` from the service every action.
- **Auto-scroll to newest + unread divider** — uses `ScrollViewReader`. Demonstrates the distinction between *UI-ephemeral* state (scroll position) and *domain* state.
- **Multi-window / iPad side-by-side chats** — using `WindowGroup` + `NavigationSplitView` + `@SceneStorage`. Lethal for naive global Redux (a single `selectedChatId` no longer works) and excellent contrast: MVVM's per-view view models handle this for free.

Open issues / PRs welcome.

## Author

SwiftUI-Architectures is created with ❤️ by [QuickBird Studios](https://quickbirdstudios.com). For more on the architectures, see [our blog post](https://quickbirdstudios.com/blog/swiftui-architecture-redux-mvvm/).

## Contributing

Open an issue if you need help, if you found a bug, or if you want to discuss a feature request. Open a PR if you want to add other SwiftUI app architectures or improve the existing ones.

## License

SwiftUI-Architectures is released under an MIT license. See [LICENSE](LICENSE) for more information.
