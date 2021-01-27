//___FILEHEADER___

import Foundation

struct SortDescription<T> {

    let areInIncreasingOrder: (T, T) -> Bool
}
