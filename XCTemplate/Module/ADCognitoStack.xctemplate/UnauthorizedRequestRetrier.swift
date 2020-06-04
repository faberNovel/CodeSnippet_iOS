//
//  UnauthorizedRequestRetrier.swift
//  HermesSaddlery
//
//  Created by Gaétan Zanella on 07/11/2019.
//

import Alamofire
import Foundation

private enum Constants {
    static let maxRetryCount = 3
}

class UnauthorizedRequestRetrier: RequestRetrier {

    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []

    // MARK: - RequestRetrier

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        lock.lock()
        defer { lock.unlock() }
        guard
            isExpiredTokenError(error),
            request.retryCount <= Constants.maxRetryCount else {
                completion(.doNotRetry)
                return
        }
        requestsToRetry.append(completion)
        guard !isRefreshing else { return }
        refreshToken { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.lock.lock()
            defer { strongSelf.lock.unlock() }
            strongSelf.requestsToRetry.forEach {
                switch result {
                case .failure:
                    $0(.doNotRetry)
                case .success:
                    $0(.retry)
                }
            }
            strongSelf.requestsToRetry.removeAll()
        }
    }

    // MARK: - Private

    private func isExpiredTokenError(_ error: Error) -> Bool {
        <#Error parsing#>
    }

    private func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !isRefreshing else { return }
        isRefreshing = true
        <#Token refresh#>
        isRefreshing = false
    }
}
