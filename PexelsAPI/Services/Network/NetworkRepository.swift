//
//  NetworkRepository.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation
import Moya

/// Выполняет сетевые запросы.
/// Возвращает распарсеную модель данных или ошибку.
class NetworkRepository<MoyaTarget: NetworkTarget> {
    
    private let provider = MoyaProvider<MoyaTarget>()
    
    @discardableResult
    func request<T: Decodable>(target: MoyaTarget, completion: @escaping (Result<T, ApiError>) -> Void) -> Cancellable {
        baseRequest(target: target) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                let decoder = ResponseDecoder<T>(data: data)
                completion(decoder.result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func baseRequest(target: MoyaTarget, completion: @escaping (Result<Data, ApiError>) -> Void) -> Cancellable {
        return provider.request(target) { [weak self] result in
            guard let self = self else { return }
            switch self.parseRequestResult(result) {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseRequestResult(_ result: Result<Response, MoyaError>) -> Result<Data, ApiError> {
        switch result {
        case .success(let response):
            return parseResponse(response)
        case .failure(_):
            return .failure(.badRequest)
        }
    }
    
    private func parseResponse(_ response: Response) -> Result<Data, ApiError> {
        switch response.statusCode {
        case (200 ..< 300):
            return .success(response.data)
        case 400:
            return .failure(.badRequest)
        case 401:
            return .failure(.unathorized)
        case 403:
            return .failure(.forbidden)
        case 404:
            return .failure(.notFound)
        case 405:
            return .failure(.methodNotAllowed)
        case 408:
            return .failure(.requestTimeout)
        case 410:
            return .failure(.gone)
        case 429:
            return .failure(.tooManyRequests)
        default:
            return .failure(.unknown(statusCode: response.statusCode))
        }
    }
}
