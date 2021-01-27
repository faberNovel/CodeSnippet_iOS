//
//  VoidHeaderViewModel.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

struct VoidHeaderViewModel: Identifiable, Equatable {
    let id = ViewID()
}

extension SectionViewModel where Header == VoidHeaderViewModel {

    static func rows(_ rows: [Row]) -> Self {
        SectionViewModel(header: VoidHeaderViewModel(), rows: rows)
    }
}

extension ListViewModel where Header == VoidHeaderViewModel {

    static func rows(_ rows: [Row]) -> Self {
        return .sections([.rows(rows)])
    }
}
