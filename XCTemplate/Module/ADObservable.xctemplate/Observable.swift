//___FILEHEADER___

import Foundation

public protocol Observable: AnyObject {
    associatedtype Observer

    var observerStorage: WeakReferenceStorage<Observer> { get set }
}

public extension Observable {

    @discardableResult
    func attach(_ observer: Observer) -> ObserverToken {
        observerStorage.store(observer)
    }

    func removeObserver(_ token: ObserverToken) {
        observerStorage.removeObserver(for: token)
    }

    func notifyObservers(_ block: (Observer) -> Void) {
        observerStorage.clean()
        observerStorage.observers().forEach { observer in
            block(observer)
        }
    }
}
