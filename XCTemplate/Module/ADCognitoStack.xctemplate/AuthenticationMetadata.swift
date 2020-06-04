//
//  AuthenticationMetadata.swift
//  HermesSaddlery
//
//  Created by Gaétan Zanella on 09/12/2019.
//

import Foundation

typealias LoginToken = String

struct AuthenticationMetadata {
    let token: LoginToken
    let userIdentifier: String
}
