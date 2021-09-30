//
//  CellReuseIdentifier.swift
//  PexelsAPI
//
//  Created by Vitaliy on 21.04.2021.
//


/// Предоставляет строковое значение reuseId для ячейки
protocol CellReuseIdentifier: SelfDescription { }

extension CellReuseIdentifier {
    static var reuseId: String {
        return selfName
    }
}
