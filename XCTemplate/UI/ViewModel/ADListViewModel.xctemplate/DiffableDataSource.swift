//___FILEHEADER___

import UIKit
import DifferenceKit

class DiffableDataSource<Header, Row> where Row: Identifiable & Equatable, Header: Identifiable & Equatable {

    typealias List = ListViewModel<Header, Row>

    private enum Kind {
        case tableView
        case collectionView
    }

    private(set) weak var tableView: UITableView?
    private(set) weak var collectionView: UICollectionView?
    private let kind: Kind

    private typealias DiffSection = DifferentiableSectionWrapper<Header, Row>

    private(set) var list: List = .empty
    private var sections: [DiffSection] = []

    // MARK: - Life Cycle

    init(tableView: UITableView) {
        self.tableView = tableView
        self.kind = .tableView
    }

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.kind = .collectionView
    }

    // MARK: - Public

    func reload(_ list: List, animated: Bool = true) {
        let origin = sections
        let target = list.diffSections()
        let changeset = StagedChangeset(source: origin, target: target)
        switch kind {
        case .collectionView:
            if animated {
                collectionView?.reload(using: changeset, setData: { [weak self] sections in
                    self?.list = list
                    self?.sections = sections
                })
            } else {
                self.list = list
                self.sections = target
                collectionView?.reloadData()
            }
        case .tableView:
            if animated {
                tableView?.reload(using: changeset, with: .fade, setData: { [weak self] sections in
                    self?.list = list
                    self?.sections = sections
                })
            } else {
                self.list = list
                self.sections = target
                tableView?.reloadData()
            }
        }
    }

    func numberOfRows(inSection section: Int) -> Int {
        guard !sections.isEmpty else { return 0 }
        return sections[section].elements.count
    }

    func numberOfSections() -> Int {
        sections.count
    }

    func rowIDs(at indexPaths: [IndexPath]) -> [Row.ID] {
        indexPaths.map { row(at: $0).id }
    }

    func row(at indexPath: IndexPath) -> Row {
        sections[indexPath.section].elements[indexPath.row].element
    }

    func header(at section: Int) -> Header {
        sections[section].section.header
    }
}

private extension ListViewModel where Header: Identifiable & Equatable, Row: Identifiable & Equatable {

    func diffSections() -> [DifferentiableSectionWrapper<Header, Row>] {
        sections.map { section in
            DifferentiableSectionWrapper(section)
        }
    }
}

/// a wrapper to avoid DifferenceKit spreading
private struct DifferentiableSectionWrapper<Header, Row>: DifferentiableSection where Header: Identifiable & Equatable,
                                                                                      Row: Identifiable & Equatable {

    typealias Collection = [DifferentiableWrapper<Row>]

    init<C>(source: DifferentiableSectionWrapper<Header, Row>, elements: C)
    where C: Swift.Collection, C.Element == DifferentiableWrapper<Row> {
        self.init(SectionViewModel(header: source.section.header, rows: elements.map { $0.element }))
    }

    let section: SectionViewModel<Header, Row>

    init(_ section: SectionViewModel<Header, Row>) {
        self.section = section
    }

    func isContentEqual(to source: DifferentiableSectionWrapper) -> Bool {
        source.section == section
    }

    var differenceIdentifier: Header.ID {
        section.id
    }

    var elements: [DifferentiableWrapper<Row>] {
        section.rows.map { DifferentiableWrapper($0) }
    }
}

/// a wrapper to avoid DifferenceKit spreading
private struct DifferentiableWrapper<T>: Differentiable where T: Equatable & Identifiable {
    let element: T

    init(_ element: T) {
        self.element = element
    }

    var differenceIdentifier: T.ID {
        return element.id
    }

    func isContentEqual(to source: DifferentiableWrapper<T>) -> Bool {
        return source.element == element
    }
}
