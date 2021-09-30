//
//  PexelsError.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation


enum ApiError: Error {
    case unknown(statusCode: Int?)
    case badRequest
    case unathorized
    case forbidden
    case notFound
    case methodNotAllowed
    case requestTimeout
    case gone
    case tooManyRequests
    case decodingFailure
}
