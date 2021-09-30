//
//  ImageCellsManager.swift
//  PexelsAPI
//
//  Created by Vitaliy on 27.01.2021.
//

import UIKit

final class ImageCellsManager: TableViewCellsManager<ImageTableViewCell, PhotoInfo> {
    
    override func cellForRowAt(indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        let cell = super.cellForRowAt(indexPath: indexPath, tableView) as! ImageTableViewCell
        let item = self[indexPath]
        cell.configure(item.image)
        return cell
    }
}
