//___FILEHEADER___

import Foundation

struct SectionViewModel<Header, Row> {
    let header: Header
    let rows: [Row]
}

extension SectionViewModel {

    var isEmpty: Bool {
        rows.isEmpty
    }
}

extension SectionViewModel: Equatable where Header: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.header == rhs.header
    }
}

extension SectionViewModel: Identifiable where Header: Identifiable {

    var id: Header.ID {
        header.id
    }
}

extension SectionViewModel {

    static func header(_ header: Header, rows: [Row]) -> Self {
        SectionViewModel(header: header, rows: rows)
    }
}
