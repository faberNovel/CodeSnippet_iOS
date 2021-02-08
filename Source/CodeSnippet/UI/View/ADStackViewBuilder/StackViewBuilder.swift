//
//  StackViewBuilder.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 29/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

@_functionBuilder
struct UIViewBuilder { // swiftlint:disable:this convenience_type

    static func buildBlock(_ views: UIView...) -> [UIView] {
        Array(views)
    }
}

func HStackView(spacing: CGFloat = 8.0,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                @UIViewBuilder arrangedSubviews: () -> [UIView]) -> UIStackView {
    let view = UIStackView(arrangedSubviews: arrangedSubviews())
    view.spacing = spacing
    view.axis = .horizontal
    view.distribution = distribution
    view.alignment = alignment
    return view
}

func VStackView(spacing: CGFloat = 8.0,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                @UIViewBuilder arrangedSubviews: () -> [UIView]) -> UIStackView {
    let view = UIStackView(arrangedSubviews: arrangedSubviews())
    view.spacing = spacing
    view.axis = .vertical
    view.distribution = distribution
    view.alignment = alignment
    return view
}

