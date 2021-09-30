//
//  ResponseDecoder.swift
//  PexelsAPI
//
//  Created by Vitaliy on 11.03.2021.
//

import Foundation

/// Парсит данные из ответа сетевого запроса в модель.
final class ResponseDecoder<T: Decodable> {
    private var model: T?
    
    var result: Result<T, ApiError> {
        if let model = model {
            return .success(model)
        } else {
            return .failure(.decodingFailure)
        }
    }

    init(data: Data) {
        model = try? decode(data)
    }

    private func decode(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
