//___FILEHEADER___

import UIKit
import MBProgressHUD

extension UIView {

    func ad_displayLoader(title: String, animated: Bool = true) {
        let hud = MBProgressHUD.showAdded(to: self, animated: animated)
        hud.label.text = title
    }

    func ad_hideLoader(animated: Bool = true) {
        MBProgressHUD.hide(for: self, animated: animated)
    }
}
