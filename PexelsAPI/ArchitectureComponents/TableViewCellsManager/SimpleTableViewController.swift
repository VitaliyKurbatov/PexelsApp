//
//  SimpleTableViewController.swift
//  PexelsAPI
//
//  Created by Vitaliy on 29.01.2021.
//

import UIKit

/// Универсальный UITableViewController, в котором все ячейки одного типа.
/// Generic UITableViewController wich contains only one type of cells.
///
/// Usage: Inherit this class to create a specific controller. Add missing methods if necessary.
///
/// - Parameters:
/// - Cell: UITableViewCell which conforms to protocols `CellReuseIdentifier` and `MadeFromXib`.
/// - ItemType:  type of item in array of dataSource.

class SimpleTableViewController<Cell: UITableViewCell & MadeFromXib, ItemType>: UITableViewController {
    
    /// Специально сделан приватным, чтобы не было возможности удаленно менять его состояние.
    /// Для обновления используйте методы Managing items или добавляйте новые.
    private let cellsManager: TableViewCellsManager<Cell, ItemType>
    
    var sections: [[ItemType]] {
        return cellsManager.sections
    }
    
    var didSelectRow: ((ItemType) -> Void)?
    
    private lazy var tableUpdateClosure = { [weak self] (closure: () -> Void) in
        guard let self = self else { return }
        self.tableView.beginUpdates()
        closure()
        self.tableView.endUpdates()
    }
    
    required init(
        cellsManager: TableViewCellsManager<Cell, ItemType>,
        didSelectRow: ((ItemType) -> Void)? = nil,
        style: UITableView.Style = .plain
    ) {
        self.cellsManager = cellsManager
        self.didSelectRow = didSelectRow
        super.init(style: style)
        tableView.register(Cell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewDataSource, UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellsManager.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsManager.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellsManager.cellForRowAt(indexPath: indexPath, tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = cellsManager.didSelectRowAt(indexPath: indexPath)
        didSelectRow?(item)
    }
    
    // MARK: - Managing items
    func findItemFor(indexPath: IndexPath) -> ItemType {
        return cellsManager[indexPath]
    }
    
    func updateDataSource(sections: [[ItemType]]) {
        cellsManager.sections = sections
        tableView.reloadData()
    }
    
    func updateDataSource(items: [ItemType]) {
        cellsManager.sections = [items]
        tableView.reloadData()
    }
    
    func addItemsToFirstSection(_ items: [ItemType]) {
        guard let firstSectionCount = cellsManager.sections.first?.count else {
            updateDataSource(items: items)
            return
        }
        
        var indices = [IndexPath]()
        var i = 0
        while i < items.count {
            let indexPath = IndexPath(row: firstSectionCount + i, section: 0)
            indices.append(indexPath)
            i += 1
        }
        
        let updates = { [weak self] in
            self?.cellsManager.sections[0].append(contentsOf: items)
            self?.tableView.insertRows(at: indices, with: .none)
        }

        tableUpdateClosure(updates)
    }
}
