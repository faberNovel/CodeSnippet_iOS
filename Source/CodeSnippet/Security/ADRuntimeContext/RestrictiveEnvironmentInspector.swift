//
//  RestrictiveEnvironmentInspector.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 18/05/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation
import UIKit

struct RestrictiveEnvironmentInspector: RuntimeCharacteristicInspecting {

    private let fileManager: FileManager
    private let application: UIApplication

    // MARK: - Life Cycle

    init(fileManager: FileManager, application: UIApplication) {
        self.fileManager = fileManager
        self.application = application
    }

    // MARK: - RuntimeCharacteristicInspecting

    func isSatisfied() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        let isUnrestrictive = hasUnauthorizedFileAccess()
            || hasUnauthorizedFilePermissions()
            || canOpenPackageURL()
        return !isUnrestrictive
        #endif
    }

    // MARK: - Private

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#file-based-checks
    private func hasUnauthorizedFileAccess() -> Bool {
        let list = [
            "/Applications/Cydia.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app",
            "/Applications/blackra1n.app",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/bin/bash",
            "/bin/sh",
            "/etc/apt",
            "/etc/ssh/sshd_config",
            "/private/var/lib/apt",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/private/var/tmp/cydia.log",
            "/var/tmp/cydia.log",
            "/usr/bin/sshd",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/usr/sbin/sshd",
            "/var/cache/apt",
            "/var/lib/apt",
            "/var/lib/cydia",
            "/usr/sbin/frida-server",
            "/usr/bin/cycript",
            "/usr/local/bin/cycript",
            "/usr/lib/libcycript.dylib",
            "/var/log/syslog"
        ]
        return list.contains { fileManager.fileExists(atPath: $0) }
    }

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#checking-file-permissions
    private func hasUnauthorizedFilePermissions() -> Bool {
        do {
            let pathToFileInRestrictedDirectory = "/private/jailbreak.txt"
            try "This is a test.".write(
                toFile: pathToFileInRestrictedDirectory,
                atomically: true,
                encoding: .utf8
            )
            try fileManager.removeItem(atPath: pathToFileInRestrictedDirectory)
            return true
        } catch {
            return false
        }
    }

    // https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#checking-protocol-handlers
    private func canOpenPackageURL() -> Bool {
        guard let url = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return application.canOpenURL(url)
    }
}
