//
//  Environment.swift
//  HermesSaddlery
//
//  Created by Gaétan Zanella on 06/11/2019.
//

import Foundation

struct CognitoEnvironment: Codable {
    let webDomain: String
    let signOutRedirectUri: String
    let signInRedirectUri: String
    let appClientId: String

    static var empty = CognitoEnvironment(
        webDomain: "",
        signOutRedirectUri: "",
        signInRedirectUri: "",
        appClientId: ""
    )
}
