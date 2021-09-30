//
//  PhotosListVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 02.02.2021.
//

import UIKit

final class PhotosListVC: CommonSearchVC {
    private let tableViewController: ImageTableVC
    var presenter: PhotosListPresenter!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.color = .gray
        }
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.buttonAction = didTapRetryButton
        view.isHidden = true
        return view
    }()
    
    private let loadMoreView = LoadMoreView()
    private var isNavBarHidden = false
    
    init(imageTableVC: ImageTableVC) {
        self.tableViewController = imageTableVC
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(isNavBarHidden, animated: false)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isNavBarHidden = navigationController?.navigationBar.isHidden ?? false
    }
    
    private func setupView() {
        addChildVC(tableViewController)
        view.pinSubviewToCenter(activityIndicator)
        view.pinSubview(errorView)
        
        setupBackButton()
        
        tableViewController.didSelectRow = { [unowned self] item in
            didSelectRow(with: item)
        }
        tableViewController.needLoadMore = { [unowned self] in
            presenter.loadNextPage()
        }
    }
    
    private func didSelectRow(with item: PhotoInfo) {
        let creator = PhotoDetailCreator(photo: item)
        let vc = creator.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapRetryButton() {
        errorView.isHidden = true
        navigationController?.hidesBarsOnSwipe = true
        presenter.retryLoad()
    }
}


extension PhotosListVC: PhotosListViewInput {
    func addPhotos(photos: [PhotoInfo]) {
        tableViewController.addItemsToFirstSection(photos)
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    func showLoadMore() {
        if tableViewController.tableView.tableFooterView == nil {
            tableViewController.tableView.tableFooterView = loadMoreView
        }
        loadMoreView.startAnimating()
    }
    
    func hideLoadMore() {
        loadMoreView.stopAnimating()
    }
    
    func removeLoadMore() {
        hideLoadMore()
        tableViewController.tableView.tableFooterView = nil
    }
    
    func showErrorView(isNeedRetryButton: Bool) {
        errorView.setHiddenRetryButton(!isNeedRetryButton)
        errorView.isHidden = false
        navigationController?.hidesBarsOnSwipe = false
    }
}


extension PhotosListVC {
    override func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        super.searchBarTextDidBeginEditing(searchBar)
        tableViewController.disableUserInteraction()
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        super.searchBarSearchButtonClicked(searchBar)
        tableViewController.enableUserInteraction()
    }
    
    override func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        super.searchBarCancelButtonClicked(searchBar)
        tableViewController.enableUserInteraction()
    }
}
