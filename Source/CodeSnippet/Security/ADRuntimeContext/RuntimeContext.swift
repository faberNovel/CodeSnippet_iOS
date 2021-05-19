//
//  RuntimeContext.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 18/05/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

struct RuntimeCharacteristics: OptionSet {

    let rawValue: Int

    static let isNotDebugged = RuntimeCharacteristics(rawValue: 1 << 0)
    static let runInRestriveEnvironment = RuntimeCharacteristics(rawValue: 1 << 1)

    static let isSafe: RuntimeCharacteristics = [.isNotDebugged, .runInRestriveEnvironment]
}

class RuntimeContext {

    // MARK: - Public

    func satisfyOrCrash(_ characteristics: RuntimeCharacteristics) {
        guard satisfy(characteristics) else {
            fatalError("Runtime not  corrumption")
        }
    }

    func satisfy(_ characteristics: RuntimeCharacteristics) -> Bool {
        var group = RunTimeCharacteristicInspectorGroup()
        if characteristics.contains(.isNotDebugged) {
            group.add(
                NotDebuggedInspector()
            )
        }
        if characteristics.contains(.runInRestriveEnvironment) {
            group.add(
                RestrictiveEnvironmentInspector(
                    fileManager: .default,
                    application: .shared
                )
            )
        }
        return group.isSatisfied()
    }
}
