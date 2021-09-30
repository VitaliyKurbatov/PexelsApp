//
//  UICollectionView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 11.02.2021.
//

import UIKit

extension UICollectionView {
    func register<T>(fromNib cellClass: T.Type) where T: UICollectionViewCell {
        register(UINib(nibName: cellClass.selfName,
                       bundle: .main),
                 forCellWithReuseIdentifier: cellClass.reuseId)
    }

    func register<T>(fromClass cellClass: T.Type) where T: UICollectionViewCell {
        register(cellClass,
                 forCellWithReuseIdentifier: cellClass.reuseId)
    }

    func register<T>(_ cell: T.Type) where T: UICollectionViewCell & MadeFromXib {
        cell.isMadeFromXib ? register(fromNib: cell.self) : register(fromClass: cell.self)
    }
}
