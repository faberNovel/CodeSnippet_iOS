//
//  UIImageView+ImageViewModel.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

extension UIImageView {

    func cs_configure(for viewModel: ImageViewModel) {
        switch viewModel.origin {
        case .bundle:
            image = viewModel.uiImage
        case .distantURL:
            break
        }
    }
}
