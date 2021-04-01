//___FILEHEADER___

import Foundation

public struct ObserverToken: Hashable {

    let uuid: UUID

    public init() {
        uuid = UUID()
    }
}
