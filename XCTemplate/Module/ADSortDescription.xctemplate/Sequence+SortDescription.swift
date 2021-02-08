//___FILEHEADER___

import Foundation

extension Sequence where Self.Element: Comparable {

    // swiftlint:disable:next line_length
    func sorted<T>(by description: SortDescription<T>) -> [Element] where T == Element {
        sorted(by: description.areInIncreasingOrder)
    }
}
