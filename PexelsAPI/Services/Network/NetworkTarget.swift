//
//  NetworkTarget.swift
//  PexelsAPI
//
//  Created by Vitaliy on 10.03.2021.
//

import Foundation
import Moya
import Alamofire

protocol NetworkTarget: TargetType {
    
}

extension NetworkTarget {
    var apiKey: String {
        return "563492ad6f91700001000001bac446f39dc74f8d90fb381663ec4905"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.pexels.com/v1/")!
    }
    
    var sampleData: Data {
        return "No data".data(using: .utf8)!
    }
    
    var defaultHTTPHeaders: [String : String] {
        return HTTPHeaders.default.dictionary
    }
    
    var additionalHeaders: [String: String] {
        return ["Authorization": apiKey]
    }
    
    var headers: [String : String]? {
        return defaultHTTPHeaders.merging(additionalHeaders) { (_, new) in new }
    }
}
