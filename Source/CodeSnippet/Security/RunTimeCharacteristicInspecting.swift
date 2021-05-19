//
//  RuntimeCharacteristicInspecting.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 19/05/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

protocol RuntimeCharacteristicInspecting {
    func isSatisfied() -> Bool
}

struct RunTimeCharacteristicInspectorGroup: RuntimeCharacteristicInspecting {

    private(set) var inspectors: [RuntimeCharacteristicInspecting] = []

    // MARK: - Public

    mutating func add(_ inspector: RuntimeCharacteristicInspecting) {
        inspectors.append(inspector)
    }

    // MARK: - RuntimeCharacteristicInspecting

    func isSatisfied() -> Bool {
        inspectors.allSatisfy { $0.isSatisfied() }
    }
}
