//___FILEHEADER___

import Foundation
import Alamofire
import PromiseKit

extension Alamofire.DataRequest {

    public func response(_: PMKNamespacer,
                         queue: DispatchQueue = .main) -> Promise<AFDataResponse<Data?>> {
        Promise { seal in
            response(queue: queue) { response in
                makeResolve(seal, with: response)
            }
        }
    }

    public func responseData(
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
                makeResolve(seal, with: $0)
            }
        }
    }

    public func responseString(
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
                makeResolve(seal, with: $0)
            }
        }
    }

    public func responseJSON(
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
                makeResolve(seal, with: $0)
            }
        }
    }
}

extension Alamofire.DownloadRequest {

    public func response(_: PMKNamespacer,
                         queue: DispatchQueue = .main) -> Promise<AFDownloadResponse<URL?>> {
        return Promise { seal in
            response(queue: queue) { makeResolve(seal, with: $0) }
        }
    }

    public func responseData(
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
                makeResolve(seal, with: $0)
            }
        }
    }
}

private func makeResolve<U>(_ seal: Resolver<AFDataResponse<U>>, with response: AFDataResponse<U>) {
    switch response.result {
    case .success:
        seal.fulfill(response)
    case .failure(let error):
        seal.reject(error)
    }
}

private func makeResolve<U>(_ seal: Resolver<AFDownloadResponse<U>>,
                            with response: AFDownloadResponse<U>) {
    switch response.result {
    case .success:
        seal.fulfill(response)
    case .failure(let error):
        seal.reject(error)
    }
}
