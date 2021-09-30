//
//  ImageService.swift
//  PexelsAPI
//
//  Created by Vitaliy on 07.02.2021.
//

import UIKit

class ImageService {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 50 * DataUnits.MB,
                                          diskCapacity: 50 * DataUnits.MB,
                                          diskPath: "URLCache/Images")
        configuration.httpMaximumConnectionsPerHost = 10
        session = URLSession(configuration: configuration)
    }
    
    func downloadImage(_ path: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            var image: UIImage?
            if let data = data {
                image = UIImage(data: data)
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    func downloadImages(_ paths: [String], completion: @escaping ([String: UIImage]) -> Void) {
        let group = DispatchGroup()
        var result = [String: UIImage]()
        
        /// не стал использовать forEach, потому что компилятор ругается и просит отправить bug report
        for path in paths {
            group.enter()
            downloadImage(path) { [path] (image) in
                result[path] = image
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(result)
        }
    }
    
    private func getContentLength(for path: String, completion: @escaping (_ contentLength: UInt?) -> Void) {
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        session.dataTask(with: request) { (data, response, error) in
            var result: UInt?
            if error == nil,
               let response = response as? HTTPURLResponse,
               let contentType = response.allHeaderFields["Content-Type"] as? String,
               contentType.contains("image"),
               let contentLength = response.allHeaderFields["Content-Length"] as? String
            {
                result = UInt(contentLength)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
    
    func getRemoteFileSize(path: String, completion: @escaping (String?) -> Void) {
        getContentLength(for: path) { bytesCount in
            guard let bytesCount = bytesCount else {
                completion(nil)
                return
            }
            let sizeText = BytesHelper.getFileSize(bytes: bytesCount)
            completion(sizeText)
        }
    }
}
