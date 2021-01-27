//
//  AlertPresenter.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

class AlertPresenter {

    var display: AlertPresenting?

    func displayAlert() {
        let alert = AlertViewModel(
            title: "toto",
            message: "toto",
            style: .alert,
            actions: [
                .destructive("Destroy") { print("BOUM") },
                .cancel()
            ]
        )
        display?.present(alert)
    }
}
