#  ListViewModel

A view model base to define lists

```swift
struct PersonRowViewModel: Identifiable, Equatable {
    let id: ViewID
    let name: String
}

struct PersonListViewModel {

    typealias List = ListViewModel<VoidHeaderViewModel, PersonRowViewModel>

    let list: List
}
```
