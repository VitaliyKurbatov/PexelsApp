//
//  CellConfigure.swift
//  PexelsAPI
//
//  Created by Vitaliy on 27.01.2021.
//


/// Требование передать модель в ячейку для установки свойств
protocol CellConfigure: AnyObject {
    associatedtype Model
    func configure(_ model: Model)
}
