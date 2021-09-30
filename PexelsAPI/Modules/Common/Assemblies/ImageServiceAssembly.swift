//
//  ImageServiceAssembly.swift
//  PexelsAPI
//
//  Created by Vitaliy on 09.02.2021.
//

import Swinject

class ImageServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImageService.self) { _ in
            return ImageService()
        }
    }
}
