//
//  Alamofire+PromiseKit.swift
//  CodeSnippet
//
//  Created by Benjamin Lavialle on 02/06/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

extension Alamofire.DataRequest {

    public func ad_response(_: PMKNamespacer,
                            queue: DispatchQueue = .main) -> Promise<AFDataResponse<Data?>> {
        Promise { seal in
            response(queue: queue) { response in
                resolve(response, with: seal)
            }
        }
    }

    public func ad_responseData(
        queue: DispatchQueue = .main,
        dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods
    ) -> Promise<AFDataResponse<Data>> {
        Promise { seal in
            responseData(
                queue: queue,
                dataPreprocessor: dataPreprocessor,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods
            ) {
                resolve($0, with: seal)
            }
        }
    }

    public func ad_responseString(
        queue: DispatchQueue = .main,
        dataPreprocessor: DataPreprocessor = StringResponseSerializer.defaultDataPreprocessor,
        encoding: String.Encoding? = nil,
        emptyResponseCodes: Set<Int> = StringResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = StringResponseSerializer.defaultEmptyRequestMethods
    ) -> Promise<AFDataResponse<String>> {
        return Promise { seal in
            responseString(
                queue: queue,
                dataPreprocessor: dataPreprocessor,
                encoding: encoding,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods
            ) {
                resolve($0, with: seal)
            }
        }
    }

    public func ad_responseJSON(
        queue: DispatchQueue = .main,
        dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods,
        options: JSONSerialization.ReadingOptions = .allowFragments
    ) -> Promise<(AFDataResponse<Any>)> {
        return Promise { seal in
            responseJSON(
                queue: queue,
                dataPreprocessor: dataPreprocessor,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods,
                options: options
            ) {
                resolve($0, with: seal)
            }
        }
    }
}

extension Alamofire.DownloadRequest {
    public func ad_response(_: PMKNamespacer,
                         queue: DispatchQueue = .main) -> Promise<AFDownloadResponse<URL?>> {
        return Promise { seal in
            response(queue: queue) { resolve($0, with: seal) }
        }
    }

    public func ad_responseData(
        queue: DispatchQueue = .main,
        dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods
    ) -> Promise<AFDownloadResponse<Data>> {
        return Promise { seal in
            responseData(
                queue: queue,
                dataPreprocessor: dataPreprocessor,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods
            ) {
                resolve($0, with: seal)
            }
        }
    }
}

private func resolve<U>(_ response: AFDataResponse<U>, with seal: Resolver<AFDataResponse<U>>) {
    switch response.result {
    case .success:
        seal.fulfill(response)
    case .failure(let error):
        seal.reject(error)
    }
}

private func resolve<U>(_ response: AFDownloadResponse<U>,
                        with seal: Resolver<AFDownloadResponse<U>>) {
    switch response.result {
    case .success:
        seal.fulfill(response)
    case .failure(let error):
        seal.reject(error)
    }
}
