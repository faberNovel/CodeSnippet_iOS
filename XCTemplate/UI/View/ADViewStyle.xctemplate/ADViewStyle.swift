//___FILEHEADER___

import UIKit

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {

    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }

    func compose(with stylingFunction: @escaping (T) -> Void) -> ViewStyle<T> {
        return compose(with: ViewStyle<T> {
            stylingFunction($0)
        })
    }
}

protocol ViewStylable {
}

extension UIView: ViewStylable {}
extension UINavigationBarAppearance: ViewStylable {}

extension ViewStylable {

    func applyStyle(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}
