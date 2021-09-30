//
//  Resolver.swift
//  PexelsAPI
//
//  Created by Vitaliy on 09.02.2021.
//



// ЗАДУМАЛ, НО ПОКА НЕ РЕАЛИЗОВЫВАЛ

/*
import Swinject 
 
enum ResolvingError: Error {
    case cannotResolveDependency(type: String, name: String?)
}

extension Resolver {
    func resolve<Dependency: SelfDescription>() throws -> Dependency {
        guard let dependency = resolve(Dependency.self) else {
            throw ResolvingError.cannotResolveDependency(type: Dependency.selfName, name: nil)
        }
        return dependency
    }

    func resolve<Dependency: SelfDescription, Identifier: RawRepresentable>(_ identifier: Identifier) throws -> Dependency where Identifier.RawValue == String {
        guard let dependency = resolve(Dependency.self, name: identifier.rawValue) else {
            throw ResolvingError.cannotResolveDependency(type: Dependency.stringDescription, name: identifier.rawValue)
        }
        return dependency
    }

    func resolveOrCrash<Dependency: SelfDescription>() -> Dependency {
        do {
            let resolvedDependency: Dependency = try resolve()
            return resolvedDependency
        } catch {
            fatalError("Cannot resolve \(Dependency.stringDescription)")
        }
    }

    func resolveOrCrash<Dependency: SelfDescription, Identifier: RawRepresentable>(
        identifiedAs identifier: Identifier
    ) -> Dependency where Identifier.RawValue == String {
        do {
            let resolvedDependency: Dependency = try resolve()
            return resolvedDependency
        } catch {
            fatalError("Cannot resolve \(Dependency.stringDescription) identified as \"\(identifier.rawValue)\"")
        }
    }
}
*/
