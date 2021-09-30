//
//  TableViewCellsManager.swift
//  PexelsAPI
//
//  Created by Vitaliy on 27.01.2021.
//

import UIKit

/// Универсальный менеджер для управления массивом однотипных переиспользуемых ячеек.
/// Generic manager that manages an array of the same reusable cells.
///
/// Использование: наследуйте этот класс для создания конкретного менеджера.
/// Если ячейка удовлетворяет протоколу `CellConfigure`, вы можете дополнительно вызвать метод configure(_ model: ) для удобства установки свойств в ячейке.
/// Usage: Inherit this class to create a specific manager.
/// If cell conforms to protocol `CellConfigure` you may want to call method configure(_ model: ) for cell.
///
/// - Parameters:
/// - Cell: UITableViewCell which conforms to protocols `CellReuseIdentifier`.
/// - ItemType:  type of item in array of dataSource.

class TableViewCellsManager<Cell: UITableViewCell, ItemType>: TableViewCellsProtocol {
    typealias Item = ItemType
    
    /// After updating this property don't forget to call tableView.reloadData()
    var sections: [[Item]]
    
    init() {
        self.sections = []
    }
    
    init(sections: [[Item]]) {
        self.sections = sections
    }
    
    /// For use with tableView wich contains only one section.
    convenience init(items: [Item]) {
        self.init(sections: [items])
    }
    
    subscript(indexPath: IndexPath) -> Item {
        return sections[indexPath.section][indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].count
    }
    
    func cellForRowAt(indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath)
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> Item {
        return self[indexPath]
    }
}
