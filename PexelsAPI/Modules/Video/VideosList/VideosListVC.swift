//
//  VideosListVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 30.09.2021.
//

import UIKit

final class VideosListVC: CommonSearchVC {
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming soon"
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = ColorPalette.shared.whiteMutable
        view.pinSubviewToCenter(infoLabel)
        navigationController?.hidesBarsOnSwipe = false
    }
}
