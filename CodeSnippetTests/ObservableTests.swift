//
//  ObservableTests.swift
//  CodeSnippetTests
//
//  Created by Gaétan Zanella on 01/04/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import XCTest
@testable import CodeSnippet

protocol MyObserverProtocol: AnyObject {
    func didUpdate()
}

class MyObserver: MyObserverProtocol {

    var hasUpdated = false

    func didUpdate() {
        hasUpdated = true
    }
}

class MyObservable {

    var referenceStorage = WeakReferenceStorage()

    func didUpdate() {
        referenceStorage.forEach(MyObserverProtocol.self) { $0.didUpdate() }
    }

    func attach<O: MyObserverProtocol>(_ observer: O) {
        referenceStorage.store(observer)
    }

    func remove<O: MyObserverProtocol>(_ observer: O) {
        referenceStorage.remove(observer)
    }
}

class ObservableTests: XCTestCase {

    var observable: MyObservable!

    override func setUpWithError() throws {
        self.observable = MyObservable()
    }

    func testNotification() throws {
        let observer = MyObserver()
        observable.attach(observer)
        XCTAssertFalse(observer.hasUpdated)
        observable.didUpdate()
        XCTAssertTrue(observer.hasUpdated)
    }

    func testDeallocation() {
        var observer: MyObserver!
        observer = MyObserver()
        observable.attach(observer)
        XCTAssertFalse(observable.referenceStorage.references().isEmpty)
        observer = nil
        XCTAssertTrue(observable.referenceStorage.references().isEmpty)
    }

    func testWeakReference() {
        var observer: MyObserver!
        observer = MyObserver()
        weak var weakReference: MyObserver? = observer
        observable.attach(observer)
        observer = nil
        XCTAssertTrue(weakReference == nil) // will be false if observable keeps a strong reference to``observer`
    }

    func testRemoval() {
        let observer = MyObserver()
        observable.attach(observer)
        XCTAssertFalse(observable.referenceStorage.references().isEmpty)
        observable.remove(observer)
        XCTAssertTrue(observable.referenceStorage.references().isEmpty)
    }
}
