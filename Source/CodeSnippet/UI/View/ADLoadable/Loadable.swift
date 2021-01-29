//
//  Loadable.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 29/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

protocol Loadable {
    func displayLoading(title: String)
    func hideLoading()
}

extension Loadable {

    func displayLoading() {
        displayLoading(title: "loading".localized())
    }
}

extension Loadable where Self: UIViewController {

    func displayLoading(title: String) {
        view.hc_displayLoader(title: title)
    }

    func hideLoading() {
        view.hc_hideLoader()
    }
}
