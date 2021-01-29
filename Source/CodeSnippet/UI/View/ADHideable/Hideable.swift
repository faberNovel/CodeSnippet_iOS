//
//  Hideable.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 29/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

protocol Hideable {
    associatedtype ContentType
    func ad_setContent(_ content: ContentType)
}

extension Hideable where Self: UIView {

    func ad_setContentOrHide(_ content: ContentType?) {
        if let unwrappedContent = content {
            ad_setContent(unwrappedContent)
            isHidden = false
        } else {
            isHidden = true
        }
    }
}

extension UILabel: Hideable {
    typealias ContentType = String

    func ad_setContent(_ content: String) {
        text = content
    }
}

extension UILabel {
    func ad_setContentOrHide(_ content: NSAttributedString?) {
        if let unwrappedContent = content {
            attributedText = unwrappedContent
            isHidden = false
        } else {
            isHidden = true
        }
    }
}

extension UIButton: Hideable {
    typealias ContentType = String

    func ad_setContent(_ content: String) {
        setTitle(content, for: .normal)
    }
}
