//
//  Sequence+SortDescription.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 26/11/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import Foundation

extension Sequence where Self.Element: Comparable {

    // swiftlint:disable:next line_length
    func sorted<Description: SortDescription>(by description: Description) -> [Element] where Description.Element == Element {
        sorted(by: description.areInIncreasingOrder)
    }
}
