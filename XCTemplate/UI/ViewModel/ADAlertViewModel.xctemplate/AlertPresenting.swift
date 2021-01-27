//___FILEHEADER___

import Foundation
import UIKit

protocol AlertPresenting {

    func present(_ alert: AlertViewModel)
}

extension AlertPresenting where Self: UIViewController {

    func present(_ alert: AlertViewModel) {
        let controller = UIAlertControllerFactory().makeViewController(alert: alert)
        present(controller, animated: true, completion: nil)
    }
}
