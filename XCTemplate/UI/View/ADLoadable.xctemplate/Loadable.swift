//___FILEHEADER___

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
