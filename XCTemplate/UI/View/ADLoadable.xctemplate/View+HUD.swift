//___FILEHEADER___

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
