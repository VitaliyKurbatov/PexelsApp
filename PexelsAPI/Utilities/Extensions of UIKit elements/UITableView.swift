//
//  UITableView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 09.02.2021.
//

import UIKit

extension UITableView {
    func register<T>(fromNib cellClass: T.Type) where T: UITableViewCell {
        register(UINib(nibName: cellClass.selfName,
                       bundle: .main),
                 forCellReuseIdentifier: cellClass.reuseId)
    }

    func register<T>(fromClass cellClass: T.Type) where T: UITableViewCell {
        register(cellClass,
                 forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func register<T>(_ cell: T.Type) where T: UITableViewCell & MadeFromXib {
        cell.isMadeFromXib ? register(fromNib: cell.self) : register(fromClass: cell.self)
    }
}
