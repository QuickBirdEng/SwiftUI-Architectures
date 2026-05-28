# QBChat — Model-View

Views own their own `@State` and call the shared `ChatService` directly. There is no view-model layer, no global store, no actions — the SwiftUI view *is* the controller, similar in spirit to MVC with UIKit.

This is the lowest-boilerplate of the three variants. The cost: business logic and UI logic live together in the same file, so anything beyond a small app starts to feel cramped. Async loading is what surfaces the trade-off most clearly — see how `ChatListView` and `ChatDetailView` introduce local `@State` plus `.task { ... }` to absorb the async results, with no abstraction sitting between the view and the service.

## Read these files in order

1. [`QBChat-ModelView/Common/QBChatApp.swift`](QBChat-ModelView/Common/QBChatApp.swift) — entry point. Constructs `MockChatService` and hands it to the root view.
2. [`QBChat-ModelView/Model/ChatService.swift`](QBChat-ModelView/Model/ChatService.swift) — the protocol the view talks to.
3. [`QBChat-ModelView/Views/ChatListView.swift`](QBChat-ModelView/Views/ChatListView.swift) — list of chats. Note `@State` + `.task { chats = await ... }`.
4. [`QBChat-ModelView/Views/ChatDetailView.swift`](QBChat-ModelView/Views/ChatDetailView.swift) — message thread + send field. Note how send + reload are sequenced manually inside the view.
