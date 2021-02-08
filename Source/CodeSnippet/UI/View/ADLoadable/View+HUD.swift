//
//  View+HUD.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 29/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIView {

    func hc_displayLoader(title: String, animated: Bool = true) {
        let hud = MBProgressHUD.showAdded(to: self, animated: animated)
        hud.label.text = title
    }

    func hc_hideLoader(animated: Bool = true) {
        MBProgressHUD.hide(for: self, animated: animated)
    }
}
