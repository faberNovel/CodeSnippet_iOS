//___FILEHEADER___

import Foundation

extension Sequence where Self.Element: Comparable {

    // swiftlint:disable:next line_length
    func sorted<Description: SortDescription>(by description: Description) -> [Element] where Description.Element == Element {
        sorted(by: description.areInIncreasingOrder)
    }
}
