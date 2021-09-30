//
//  PhotosListProtocols.swift.swift
//  PexelsAPI
//
//  Created by Vitaliy on 02.02.2021.
//


// MARK: - PhotosListPresenter
protocol PhotosListOutput: AnyObject {
    func viewDidLoad()
    func loadNextPage()
    func retryLoad()
}


// MARK: - PhotosListView
protocol PhotosListViewInput: AnyObject {
    func addPhotos(photos: [PhotoInfo])
    func showLoader()
    func hideLoader()
    func showLoadMore()
    func hideLoadMore()
    func removeLoadMore()
    func showErrorView(isNeedRetryButton: Bool)
}
