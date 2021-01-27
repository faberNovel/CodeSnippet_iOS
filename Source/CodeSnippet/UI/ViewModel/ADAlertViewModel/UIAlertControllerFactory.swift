//
//  UIAlertControllerFactory.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation
import UIKit

struct UIAlertControllerFactory {

    func makeViewController(alert: AlertViewModel) -> UIAlertController {
        let controller = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: alert.style.uiStyle
        )
        alert.actions.forEach { action in
            let uiAction = UIAlertAction(
                title: action.title,
                style: action.style.uiStyle,
                handler: { _ in
                    action.handler()
                }
            )
            controller.addAction(uiAction)
        }
        return controller
    }
}

private extension AlertActionViewModel.Style {

    var uiStyle: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .default:
            return .default
        case .destructive:
            return .destructive
        }
    }
}

private extension AlertViewModel.Style {

    var uiStyle: UIAlertController.Style {
        switch self {
        case .alert:
            return .alert
        case .sheet:
            return .actionSheet
        }
    }
}
