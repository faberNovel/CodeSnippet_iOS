//___FILEHEADER___

import Foundation

public protocol Observable: AnyObject {
    associatedtype Observer

    var observerByToken: [ObserverToken: WeakWrapper<Observer>] { get set }
}

public extension Observable {

    @discardableResult
    func attach(_ observer: Observer) -> ObserverToken {
        let token = ObserverToken()
        observerByToken[token] = WeakWrapper(observer)
        return token
    }

    func removeObserver(_ token: ObserverToken) {
        observerByToken.removeValue(forKey: token)
    }

    func notifyObservers(_ block: (Observer) -> Void) {
        cleanObservers()
        observerByToken.values.forEach { wrapper in
            guard let value = wrapper.value as? Observer else { return }
            block(value)
        }
    }

    private func cleanObservers() {
        observerByToken = observerByToken.filter { $0.value.value != nil }
    }
}

public class WeakWrapper<T> {

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
