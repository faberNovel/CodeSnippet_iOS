//
//  Sequence+LocalizedOrder.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

extension Sequence where Element == String {

    // swiftlint:disable:next line_length
    func isInLocalizedIncreasingOrder<OtherSequence>(comparedTo other: OtherSequence) -> Bool where OtherSequence: Sequence, Self.Element == OtherSequence.Element {
        lexicographicallyPrecedes(other) {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        }
    }
}
