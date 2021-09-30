//
//  SimpleTableViewController+Extension.swift
//  PexelsAPI
//
//  Created by Vitaliy on 30.09.2021.
//

extension SimpleTableViewController {
    func enableUserInteraction() {
        tableView.isScrollEnabled = true
        tableView.allowsSelection = true
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func disableUserInteraction() {
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        navigationController?.hidesBarsOnSwipe = false
    }
}
