//___FILEHEADER___

import Foundation

public struct WeakReferenceStorage<Observer> {

    private var observerByToken: [ObserverToken: WeakWrapper<Observer>] = [:]

    public init() {}

    public func observers() -> [Observer] {
        observerByToken.values.compactMap { $0 as? Observer }
    }

    public func observer(for token: ObserverToken) -> Observer? {
        observerByToken[token]?.value as? Observer
    }

    public mutating func removeObserver(for token: ObserverToken) {
        observerByToken.removeValue(forKey: token)
    }

    public mutating func store(_ observer: Observer) -> ObserverToken {
        let token = ObserverToken()
        observerByToken[token] = WeakWrapper(observer)
        return token
    }

    public mutating func clean() {
        observerByToken = observerByToken.filter { $0.value.value != nil }
    }
}

private class WeakWrapper<T> {

    weak var value: AnyObject?

    init(_ value: T) {
        self.value = value as AnyObject
    }
}

extension WeakWrapper: Hashable {

    public func hash(into hasher: inout Hasher) {
        value.flatMap { hasher.combine(ObjectIdentifier($0)) }
    }

    public static func == (lhs: WeakWrapper<T>, rhs: WeakWrapper<T>) -> Bool {
        lhs.value === rhs.value
    }
}
