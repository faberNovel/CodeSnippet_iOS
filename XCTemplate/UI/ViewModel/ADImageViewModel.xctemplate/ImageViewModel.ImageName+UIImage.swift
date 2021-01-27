//___FILEHEADER___

import UIKit

extension ImageViewModel {

    var uiImage: UIImage? {
        switch origin {
        case let .bundle(name):
            return name.image
        case .distantURL:
            return nil
        }
    }
}

extension ImageName {

    // use swiftgen
    var uiImage: UIImage? {
        <#image#>
    }
}
