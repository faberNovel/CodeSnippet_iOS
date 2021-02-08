//
//  ViewStyle+CSButton.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 28/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

extension ViewStyle where T == CSButton {

    static var validation: ViewStyle {
        ViewStyle { button in
            if button.isHighlighted {
                button.backgroundColor = .black
            } else {
                button.backgroundColor = .white
            }
        }
    }
}
