//
//  NotDebuggedInspector.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 19/05/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

struct NotDebuggedInspector: RuntimeCharacteristicInspecting {

    // MARK: - RunTimeCharacteristicInspecting

    func isSatisfied() -> Bool {
        !(isDebugged() || isLauchedByDebugger())
    }

    // MARK: - Private

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#using-sysctl
    private func isDebugged() -> Bool {
        SysctlInspector().isActive()
    }

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#using-getppid
    private func isLauchedByDebugger() -> Bool {
        getppid() != 1
    }
}
