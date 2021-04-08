//
//  WeakReferenceStorage.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 01/04/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

public struct WeakReferenceStorage {

    private var referenceById: [ObjectIdentifier: WeakWrapper] = [:]

    public init() {}

    public func references() -> [AnyObject] {
        referenceById.values.compactMap { $0.value }
    }

    public func forEach<Ref>(_ type: Ref.Type, _ body: (Ref) -> Void) {
        referenceById.values.forEach { reference in
            guard let observer = reference.value as? Ref else { return }
            body(observer)
        }
    }

    public mutating func store(_ reference: AnyObject) {
        referenceById[ObjectIdentifier(reference)] = WeakWrapper(reference)
    }

    public mutating func remove(_ reference: AnyObject) {
        referenceById.removeValue(forKey: ObjectIdentifier(reference))
    }

    public mutating func clean() {
        referenceById = referenceById.filter { $0.value.value != nil }
    }
}

private class WeakWrapper {

    weak var value: AnyObject?

    init(_ value: AnyObject) {
        self.value = value
    }
}
