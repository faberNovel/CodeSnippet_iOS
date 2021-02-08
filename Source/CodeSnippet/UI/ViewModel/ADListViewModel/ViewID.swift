//
//  ViewID.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

/// An opaque ID to identify views.
///
///     ViewID("section_identifier", "row_identifier")
struct ViewID: Hashable {

    typealias Component = String

    private let components: [Component]

    init() {
        self.components = []
    }

    init(_ components: Component...) {
        self.components = components
    }

    var first: Component {
        if let first = components.first {
            return first
        }
        assertionFailure("Components is empty")
        return ""
    }

    var last: Component {
        if let last = components.last {
            return last
        }
        assertionFailure("Components is empty")
        return ""
    }

    subscript(index: Int) -> Component {
        if index < components.count && index >= 0 {
            return components[index]
        } else {
            assertionFailure("\(index) out of bounds in \(components)")
            return ""
        }
    }
}

extension ViewID {

    init<S: RawRepresentable>(section: S) where S.RawValue == String {
        self.components = [section.rawValue]
    }

    // swiftlint:disable:next line_length
    init<S: RawRepresentable, R: RawRepresentable>(section: S, row: R) where S.RawValue == String, R.RawValue == String {
        self.components = [section.rawValue, row.rawValue]
    }

    func section<S: RawRepresentable>(_ section: S.Type) -> S? where S.RawValue == String {
        S(rawValue: first)
    }

    func row<R: RawRepresentable>(_ row: R.Type) -> R? where R.RawValue == String {
        R(rawValue: last)
    }
}
