//
//  RuntimeCharacteristicInspecting.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 19/05/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

protocol RuntimeCharacteristicInspecting {
    func satisfy() throws
}

struct RunTimeCharacteristicInspectorGroup: RuntimeCharacteristicInspecting {

    private(set) var inspectors: [RuntimeCharacteristicInspecting] = []

    // MARK: - Public

    mutating func add(_ inspector: RuntimeCharacteristicInspecting) {
        inspectors.append(inspector)
    }

    // MARK: - RuntimeCharacteristicInspecting

    func satisfy() throws {
        for inspector in inspectors {
            try inspector.satisfy()
        }
    }
}
