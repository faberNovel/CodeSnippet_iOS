//___FILEHEADER___

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
