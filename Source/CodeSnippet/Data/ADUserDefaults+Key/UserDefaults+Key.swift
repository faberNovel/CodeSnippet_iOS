//
//  UserDefaults+Key.swift
//  XCTemplate
//
//  Created by Gaétan Zanella on 15/05/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import Foundation

extension UserDefaults {

    enum Key: String {
        case myKey
    }
}

extension UserDefaults {

    func registerDefaults(_ defaults: [Key: Any]) {
        register(defaults: defaults.reduce(into: [:]) { result, x in
            result[x.key.rawValue] = x.value
        })
    }
}

extension UserDefaults {

    func object(for key: Key) -> Any? {
        object(forKey: key.rawValue)
    }

    func set(_ value: Any?, for key: Key) {
        set(value, forKey: key.rawValue)
    }

    func removeObject(for key: Key) {
        removeObject(forKey: key.rawValue)
    }

    func string(for key: Key) -> String? {
        string(forKey: key.rawValue)
    }

    func array(for key: Key) -> [Any]? {
        array(forKey: key.rawValue)
    }

    func dictionary(for key: Key) -> [String: Any]? {
        dictionary(forKey: key.rawValue)
    }

    func data(for key: Key) -> Data? {
        data(forKey: key.rawValue)
    }

    func stringArray(for key: Key) -> [String]? {
        stringArray(forKey: key.rawValue)
    }

    func integer(for key: Key) -> Int {
        integer(forKey: key.rawValue)
    }

    func float(for key: Key) -> Float {
        float(forKey: key.rawValue)
    }

    func double(for key: Key) -> Double {
        double(forKey: key.rawValue)
    }

    func bool(for key: Key) -> Bool {
        bool(forKey: key.rawValue)
    }

    func url(for key: Key) -> URL? {
        url(forKey: key.rawValue)
    }

    func set(_ value: Int, for key: Key) {
        set(value, forKey: key.rawValue)
    }

    func set(_ value: Float, for key: Key) {
        set(value, forKey: key.rawValue)
    }

    func set(_ value: Double, for key: Key) {
        set(value, forKey: key.rawValue)
    }

    func set(_ value: Bool, for key: Key) {
        set(value, forKey: key.rawValue)
    }

    func set(_ url: URL?, for key: Key) {
        set(url, forKey: key.rawValue)
    }
}
