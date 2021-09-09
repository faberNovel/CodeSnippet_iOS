//___FILEHEADER___

import Foundation

struct RuntimeCharacteristics: OptionSet {

    let rawValue: Int

    static let isNotDebugged = RuntimeCharacteristics(rawValue: 1 << 0)
    static let runInRestrictiveEnvironment = RuntimeCharacteristics(rawValue: 1 << 1)

    static let isSafe: RuntimeCharacteristics = [.isNotDebugged, .runInRestrictiveEnvironment]
}

class RuntimeContext {

    // MARK: - Public

    func satisfyOrCrash(_ characteristics: RuntimeCharacteristics) {
        do {
            try satisfy(characteristics)
        } catch {
            fatalError("Invalid runtime")
        }
    }

    func satisfy(_ characteristics: RuntimeCharacteristics) throws {
        var group = RunTimeCharacteristicInspectorGroup()
        if characteristics.contains(.isNotDebugged) {
            group.add(
                NotDebuggedInspector()
            )
        }
        if characteristics.contains(.runInRestrictiveEnvironment) {
            group.add(
                RestrictiveEnvironmentInspector(
                    fileManager: .default,
                    application: .shared
                )
            )
        }
        try group.satisfy()
    }
}
