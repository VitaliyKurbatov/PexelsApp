//
//  SelfDescription.swift
//  PexelsAPI
//
//  Created by Vitaliy on 22.05.2021.
//

/// Предоставляет наименование подписавшегося элемента в виде строки
protocol SelfDescription {
    //static var selfName: String { get }  // отключено для статической диспетчеризации
}

extension SelfDescription {
    static var selfName: String {
        return String(describing: Self.self)
    }
}
