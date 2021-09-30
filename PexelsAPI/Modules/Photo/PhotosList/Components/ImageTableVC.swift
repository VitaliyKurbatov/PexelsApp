//
//  ImageTableVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 05.02.2021.
//

import UIKit

final class ImageTableVC: SimpleTableViewController<ImageTableViewCell, PhotoInfo> {
    /// сообщает о необходимости подгрузки данных
    var needLoadMore: (() -> Void)?
    /// за сколько ячеек до конца tableView начнется подгрузка данных
    private let sentinelValueForLoadMore = 7
    private let verticalPadding = ImageTableViewCell.verticalPadding
    
    convenience init(cellsManager: ImageCellsManager) {
        self.init(cellsManager: cellsManager, didSelectRow: nil, style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt(indexPath: indexPath)
    }
    
    // Масштабирование фотографии по ширине экана осуществлено за счет ограничения высоты ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt(indexPath: indexPath)
    }
    
    private func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let item = findItemFor(indexPath: indexPath)
        return item.scaledSize.height + verticalPadding
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let firstSection = sections.first, !firstSection.isEmpty else { return }
        if indexPath.row >= firstSection.count - sentinelValueForLoadMore {
            needLoadMore?()
        }
    }
}
