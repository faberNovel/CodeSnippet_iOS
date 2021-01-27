//
//  ImageViewModel.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

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
