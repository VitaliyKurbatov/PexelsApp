//
//  TableViewDataStorageProtocol.swift
//  PexelsAPI
//
//  Created by Vitaliy on 29.01.2021.
//


/// Требование предоставить массив элементов для использования их в качестве DataSource.
protocol TableViewDataStorageProtocol: AnyObject {
    associatedtype Item
    var sections: [[Item]] { get set }
}
