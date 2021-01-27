//___FILEHEADER___

import Foundation
import ADUtils

struct AlertActionViewModel {

    enum Style {
        case cancel, destructive, `default`
    }

    let title: String
    let style: Style
    let handler: () -> Void
}

extension AlertActionViewModel {

    private static func text(_ title: String, style: Style = .default, handler: @escaping () -> Void) -> Self {
        AlertActionViewModel(
            title: title,
            style: style,
            handler: handler
        )
    }

    static func text(_ text: String, handler: @escaping () -> Void) -> Self {
        .text(text, style: .default, handler: handler)
    }

    static func destructive(_ text: String, handler: @escaping () -> Void) -> Self {
        .text(text, style: .destructive, handler: handler)
    }

    static func cancel(_ text: String = "cancel".localized(), handler: (() -> Void)? = nil) -> Self {
        .text(text, style: .cancel, handler: { handler?() })
    }
}
