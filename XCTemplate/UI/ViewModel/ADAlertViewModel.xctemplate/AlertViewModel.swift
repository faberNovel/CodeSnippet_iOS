//___FILEHEADER___

import Foundation

struct AlertViewModel {

    enum Style {
        case sheet, alert
    }

    let title: String
    let message: String
    let style: Style
    let actions: [AlertActionViewModel]
}

extension AlertViewModel {

    static func alert(title: String, message: String, actions: [AlertActionViewModel]) -> AlertViewModel {
        AlertViewModel(title: title, message: message, style: .alert, actions: actions)
    }

    static func sheet(title: String, message: String, actions: [AlertActionViewModel]) -> AlertViewModel {
        AlertViewModel(title: title, message: message, style: .sheet, actions: actions)
    }
}
