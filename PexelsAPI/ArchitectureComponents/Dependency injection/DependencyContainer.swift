//
//  DependencyContainer.swift
//  PexelsAPI
//
//  Created by Vitaliy on 24.02.2021.
//

import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    private init() { }
    
    private let assembler = Assembler()
    var resolver: Resolver {
        return assembler.resolver
    }
    
    private lazy var assemblies: [Assembly] = {
        return [
            ImageServiceAssembly(),
            PhotosRepositoryAssembly()
        ]
    }()
    
    func configure() {
        assembler.apply(assemblies: assemblies)
    }
}
