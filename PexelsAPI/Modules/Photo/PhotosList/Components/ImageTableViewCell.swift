//
//  ImageTableViewCell.swift
//  PexelsAPI
//
//  Created by Vitaliy on 26.01.2021.
//

import UIKit

final class ImageTableViewCell: UITableViewCell, MadeFromXib, CellConfigure {
    typealias Model = UIImage?
    static let isMadeFromXib = false
    
    static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    static var verticalPadding: CGFloat {
        return insets.top + insets.bottom
    }
    
    let mainImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        contentView.pinSubview(mainImageView, insets: Self.insets)
        mainImageView.contentMode = .scaleAspectFit
    }
    
    func configure(_ model: Model) {
        mainImageView.image = model
    }
}
