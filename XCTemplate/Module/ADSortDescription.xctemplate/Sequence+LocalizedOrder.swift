//___FILEHEADER___

import Foundation

extension Sequence where Element == String {

    // swiftlint:disable:next line_length
    func isInLocalizedIncreasingOrder<OtherSequence>(comparedTo other: OtherSequence) -> Bool where OtherSequence: Sequence, Self.Element == OtherSequence.Element {
        lexicographicallyPrecedes(other) {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        }
    }
}
