//
//  NotDebuggedInspector.swift
//  RuntimeContext
//
//  Created by Thomas Esterlin on 09/09/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

extension NotDebuggedInspector {
    enum Error: Swift.Error {
        case isDebugged
        case isLaunchedByDebugger
    }
}

struct NotDebuggedInspector: RuntimeCharacteristicInspecting {

    // MARK: - RunTimeCharacteristicInspecting

    func satisfy() throws {
        if isDebugged() {
            throw Error.isDebugged
        }
        if isLaunchedByDebugger() {
            throw Error.isLaunchedByDebugger
        }
    }

    // MARK: - Private

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#using-sysctl
    private func isDebugged() -> Bool {
        SysctlInspector().isActive()
    }

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#using-getppid
    private func isLaunchedByDebugger() -> Bool {
        getppid() != 1
    }
}

