//
//  Sequence+SortDescription.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

extension Sequence where Self.Element: Comparable {

    // swiftlint:disable:next line_length
    func sorted<T>(by description: SortDescription<T>) -> [Element] where T == Element {
        sorted(by: description.areInIncreasingOrder)
    }
}
