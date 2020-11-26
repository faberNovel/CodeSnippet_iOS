//___FILEHEADER___

import Foundation

protocol SortDescription {

    associatedtype Element

    func areInIncreasingOrder(_ lhs: Element, _ rhs: Element) -> Bool
}
