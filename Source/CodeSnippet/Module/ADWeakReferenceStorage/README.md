
# WeakReferenceStorage

A weak reference container specially designed for recreating observer patterns.

```swift
protocol Observer: AnyObject {
    func didUpdate()
}

class ObserverObject: Observer {

    func didUpdate() { ... }
}

class ObservableObject {

    private var referenceStorage = WeakReferenceStorage()

    func attach<O: Observer>(_ observer: O) {
        referenceStorage.store(observer)
    }

    func remove<O: Observer>(_ observer: O) {
        referenceStorage.remove(observer)
    }
    
    private func didUpdate() {
        referenceStorage.forEach(MyObserverProtocol.self) { $0.didUpdate() }
    }
}
```

- `WeakReferenceStorage.swift`: A weak reference container.
