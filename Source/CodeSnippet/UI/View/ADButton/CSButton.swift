//
//  ADButton.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 28/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

/// A `UIButton` subclass working gracefully with `ViewStyle`.
///
/// `ViewStyle.style` will be called multiple times, possibly in animation blocks, when the button state changes.
final class CSButton: UIButton {

    private var style: ViewStyle<CSButton>?

    private var expectedIntrinsicContentSize: CGSize?

    // MARK: - UIView

    override func layoutSubviews() {
        super.layoutSubviews()
        style?.style(self)
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        setNeedsLayout()
    }

    override var isHighlighted: Bool {
        get {
            super.isHighlighted
        }
        set {
            animateStateChange {
                super.isHighlighted = newValue
            }
        }
    }

    override var isEnabled: Bool {
        get {
            super.isEnabled
        }
        set {
            animateStateChange {
                super.isEnabled = newValue
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        if let size = expectedIntrinsicContentSize {
            return size
        }
        return super.intrinsicContentSize
    }

    // MARK: - ViewStylable

    convenience init(style: ViewStyle<CSButton>) {
        self.init(type: .custom)
        applyStyle(style)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    func applyStyle(_ style: ViewStyle<CSButton>) {
        self.style = style
        style.style(self)
        setNeedsLayout()
    }

    // MARK: - Public

    func setIntrinsicContentSize(_ size: CGSize) {
        guard size != expectedIntrinsicContentSize else { return }
        expectedIntrinsicContentSize = size
        invalidateIntrinsicContentSize()
    }

    // MARK: - Private

    private func animateStateChange(stateUpdate: () -> Void) {
        layoutIfNeeded()
        stateUpdate()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}
