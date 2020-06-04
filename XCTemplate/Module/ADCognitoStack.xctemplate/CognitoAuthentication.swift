//
//  CognitoAuthentication.swift
//  XCTemplate
//
//  Created by Gaétan Zanella on 02/06/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import AWSCognitoAuth
import Foundation

private enum Constants {
    static let authKey = "cognitoAuth"
}

class CognitoAuthentication: NSObject, AWSCognitoAuthDelegate {

    enum AuthenticationError: Error {
        case unknown
    }

    private let environment: CognitoEnvironment

    private var auth: AWSCognitoAuth {
        return AWSCognitoAuth(forKey: Constants.authKey)
    }

    // MARK: - Life Cycle

    init(environment: CognitoEnvironment) {
        self.environment = environment
        super.init()
        registerConfiguration()
        auth.delegate = self
    }

    // MARK: - Public

    func isSignedIn() -> Bool {
        return auth.isSignedIn
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return auth.application(app, open: url, options: options)
    }

    func refreshSession(completion: @escaping (Result<AuthenticationMetadata, Error>) -> Void) {
        auth.getSession { session, error in
            if let data = session?.toMetadata() {
                completion(.success(data))
            } else {
                completion(.failure(error ?? AuthenticationError.unknown))
            }
        }
    }

    func signIn(completion: @escaping (Result<AuthenticationMetadata, Error>) -> Void) {
        auth.getSession { session, error in
            if let data = session?.toMetadata() {
                completion(.success(data))
            } else {
                completion(.failure(error ?? AuthenticationError.unknown))
            }
        }
    }

    func signOutLocally() {
        auth.signOutLocallyAndClearLastKnownUser()
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        signOutLocally()
        auth.signOut { error in
            completion(error.flatMap { .failure($0) } ?? .success(()))
        }
    }

    func signOut(with controller: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signOut(controller) { error in
            completion(error.flatMap { .failure($0) } ?? .success(()))
        }
    }

    // MARK: - AWSCognitoAuthDelegate

    func getViewController() -> UIViewController {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        guard let viewController = root?.topPresentedViewController() else {
            fatalError("Sign in error, there is no view controller currently on screen")
        }
        return viewController
    }

    func shouldLaunchSignInVCIfRefreshTokenIsExpired() -> Bool {
        return false
    }

    // MARK: - Private

    private func registerConfiguration() {
        let configuration = AWSCognitoAuthConfiguration(
            appClientId: environment.appClientId,
            appClientSecret: nil,
            scopes: Set([]),
            signInRedirectUri: environment.signInRedirectUri,
            signOutRedirectUri: environment.signOutRedirectUri,
            webDomain: environment.webDomain,
            identityProvider: nil,
            idpIdentifier: nil,
            userPoolIdForEnablingASF: nil
        )
        AWSCognitoAuth.registerCognitoAuth(with: configuration, forKey: Constants.authKey)
    }
}

private extension AWSCognitoAuthUserSession {

    func toMetadata() -> AuthenticationMetadata? {
        guard let token = idToken?.tokenString,
            let username = username else {
            return nil
        }
        return AuthenticationMetadata(
            token: token,
            userIdentifier: username
        )
    }
}

private extension UIViewController {

    func topPresentedViewController() -> UIViewController {
        if let viewController = presentedViewController {
            return viewController.topPresentedViewController()
        }
        return self
    }
}
