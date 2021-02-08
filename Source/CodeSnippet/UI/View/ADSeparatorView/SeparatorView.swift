//
//  SeparatorView.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit
import ADUtils

class SeparatorView: UIView {

    var edge: UIRectEdge = .bottom {
        didSet {
            setNeedsDisplay()
        }
    }

    var separatorColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    var separatorHeight: CGFloat = UIScreen.main.ad_pixelDimension {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    // MARK: - UIView

    override func draw(_ rect: CGRect) {
        separatorColor.setFill()
        UIRectFill(rect)
        UIRectClip(clipppingRect(for: edge, in: rect))
        UIColor.clear.setFill()
        UIRectFill(rect)
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: max(separatorHeight, 1))
    }

    // MARK: - Private

    private func setUpView() {
        backgroundColor = .clear
    }

    private func clipppingRect(for edge: UIRectEdge, in rect: CGRect) -> CGRect {
        var width = rect.width
        if edge.contains(.left) {
            width -= separatorHeight
        }
        if edge.contains(.right) {
            width -= separatorHeight
        }
        var height = rect.height
        if edge.contains(.top) {
            height -= separatorHeight
        }
        if edge.contains(.bottom) {
            height -= separatorHeight
        }
        return CGRect(
            x: edge.contains(.left) ? separatorHeight : 0,
            y: edge.contains(.top) ? separatorHeight : 0,
            width: width,
            height: height
        )
    }
}
