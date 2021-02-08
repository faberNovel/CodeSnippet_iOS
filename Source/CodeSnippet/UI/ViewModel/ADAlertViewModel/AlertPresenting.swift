//
//  AlertPresenting.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

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
