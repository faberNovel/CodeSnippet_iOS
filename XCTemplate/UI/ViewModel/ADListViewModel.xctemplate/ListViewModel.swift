//___FILEHEADER___

import Foundation

struct ListViewModel<Header, Row> {

    typealias Section = SectionViewModel<Header, Row>

    struct IndexEntry {
        let title: String
        let sectionIndex: Int
    }

    let sections: [Section]
    let indexes: [IndexEntry]
}

extension ListViewModel {

    static var empty: ListViewModel<Header, Row> { ListViewModel(sections: [], indexes: []) }

    func header(at section: Int) -> Header {
        sections[section].header
    }

    func section(at index: Int) -> SectionViewModel<Header, Row> {
        sections[index]
    }

    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfRows(inSection section: Int) -> Int {
        rows(in: section).count
    }

    func rows(in section: Int) -> [Row] {
        sections[section].rows
    }

    subscript(indexPath: IndexPath) -> Row {
        sections[indexPath.section].rows[indexPath.row]
    }

    var isEmpty: Bool {
        sections.isEmpty
    }
}

extension ListViewModel where Row: Identifiable {

    func indexPath(of id: Row.ID) -> IndexPath? {
        for (s, section) in sections.enumerated() {
            for (r, row) in section.rows.enumerated() where row.id == id {
                return IndexPath(row: r, section: s)
            }
        }
        return nil
    }

    func indexPaths(of rows: [Row.ID]) -> [IndexPath] {
        rows.compactMap { indexPath(of: $0) }
    }

    func rowIDs(at indexPaths: [IndexPath]) -> [Row.ID] {
        indexPaths.map { self[$0].id }
    }
}

extension ListViewModel {

    static func sections(_ sections: [SectionViewModel<Header, Row>], indexes: [IndexEntry] = []) -> Self {
        ListViewModel(sections: sections, indexes: indexes)
    }
}
