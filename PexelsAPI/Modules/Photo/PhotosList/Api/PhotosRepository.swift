//
//  PhotosRepository.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation


final class PhotosRepository: NetworkRepository<PhotosApi> {
    
    func getRecentPhotos(page: UInt, completion: @escaping (Result<RecentPhotos, ApiError>) -> Void) {
        request(target: .recentPhotos(page: page),
                completion: completion)
    }
}
