//
//  ImageViewModel.ImageName+UIImage.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

extension ImageViewModel {

    var uiImage: UIImage? {
        switch origin {
        case let .bundle(name):
            return name.uiImage
        case .distantURL:
            return nil
        }
    }
}

extension ImageName {

    // use swiftgen
    var uiImage: UIImage? {
        switch self {
        case .anIcon:
            return nil
        }
    }
}
