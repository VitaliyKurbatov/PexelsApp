//
//  CommonSearchVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 02.02.2021.
//

import UIKit

class CommonSearchVC: UIViewController {
    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupSearchBar()
    }
    
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter keywords"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationController?.hidesBarsOnSwipe = true
    }
}

extension CommonSearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            // dirty hack for dirty iOS :(
            cancelButton.isEnabled = true
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
}
