//___FILEHEADER___

import Foundation

struct ImageViewModel: Equatable {

    enum Origin: Equatable {
        case bundle(ImageName)
        case distantURL(String)
    }

    let origin: Origin
}

extension ImageViewModel {

    static func named(_ name: ImageName) -> ImageViewModel {
        ImageViewModel(origin: .bundle(name))
    }

    static func fromURL(_ url: String) -> ImageViewModel {
        ImageViewModel(origin: .distantURL(url))
    }
}
