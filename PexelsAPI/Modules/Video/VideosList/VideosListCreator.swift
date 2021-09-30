//
//  VideosListCreator.swift
//  PexelsAPI
//
//  Created by Vitaliy on 30.09.2021.
//

import UIKit
import Swinject

struct VideosListCreator: ModuleCreator, SelfDescription {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func createModule() -> UIViewController {
        return VideosListVC()
    }
}
