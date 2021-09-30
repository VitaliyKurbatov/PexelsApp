//
//  TableViewCellsProtocol.swift
//  PexelsAPI
//
//  Created by Vitaliy on 27.01.2021.
//

import UIKit


/// Требование предоставить минимально необходимые методы для работы с tableView.
protocol TableViewCellsProtocol: TableViewDataStorageProtocol {
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath) -> Item
}


