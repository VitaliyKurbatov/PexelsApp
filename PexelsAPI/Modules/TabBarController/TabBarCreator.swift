//
//  TabBarCreator.swift
//  PexelsAPI
//
//  Created by Vitaliy on 10.02.2021.
//

import UIKit
import Swinject

struct TabBarCreator: ModuleCreator, SelfDescription {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func createModule() -> UIViewController {
        let photosCreator = PhotosListCreator(resolver: resolver)
        let videosCreator = VideosListCreator(resolver: resolver)
        
        guard let photosVC = photosCreator.createModule() as? PhotosListVC,
              let videosVC = videosCreator.createModule() as? VideosListVC else {
            fatalError("Cannot create \(Self.selfName)")
        }
        return TabBarController(photosVC: photosVC, videosVC: videosVC)
    }
}
