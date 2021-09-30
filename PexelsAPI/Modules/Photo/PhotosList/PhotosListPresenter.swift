//
//  PhotosListPresenter.swift
//  PexelsAPI
//
//  Created by Vitaliy on 02.02.2021.
//

import Foundation

final class PhotosListPresenter: PhotosListOutput {
    private let repository: PhotosRepository
    private let service: ImageService
    weak var view: PhotosListViewInput?
    
    private let startPage: UInt = 1  // начнем загружать с первой страницы. Нулевая косячит.
    private var currentPage: UInt
    private var retryCount: UInt8 = 0
    private let maximumRetryCount: UInt8 = 2
    private var loadState: LoadState<[PhotoInfo]> = .undefined {
        didSet {
            checkLoadState()
        }
    }
    
    init(repository: PhotosRepository, service: ImageService) {
        self.repository = repository
        self.service = service
        currentPage = startPage
    }
    
    func viewDidLoad() {
        loadNextPage()
    }
    
    func loadNextPage() {
        if loadState == .loading || loadState == .failed(.notFound) {  // * содержание связанного значения не влияет на процедуру сравнения
            return
        }
        loadState = .loading
        
        repository.getRecentPhotos(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recentPhotos):
                self.downloadPhotos(recentPhotos.photosInfo) { [weak self] photosInfo in
                    guard let self = self else { return }
                    let filteredInfo = photosInfo.filter { $0.image != nil }
                    
                    if filteredInfo.isEmpty {
                        self.loadState = .failed(.unknown(statusCode: nil))
                    } else {
                        self.loadState = .loaded(filteredInfo)
                        self.currentPage += 1
                    }
                }
            case .failure(let error):
                self.loadState = .failed(error)
            }
        }
    }
    
    private func downloadPhotos(_ photosInfo: [PhotoInfo], completion: @escaping ([PhotoInfo]) -> Void) {
        let urls = photosInfo.map { $0.thumbPathRemote }
        
        service.downloadImages(urls) { [photosInfo] imageDict in
            var result = photosInfo
            for (index, photo) in photosInfo.enumerated() {
                guard let image = imageDict[photo.thumbPathRemote] else { continue }
                result[index].image = image
                result[index].scaledSize = image.scaledSizeToScreenWidth
            }
            completion(result)
        }
    }
    
    func retryLoad() {
        retryCount += 1
        currentPage = startPage
        loadState = .undefined
        loadNextPage()
    }
    
    private func checkLoadState() {
        switch loadState {
        case .undefined:
            break
            
        case .loading:
            if currentPage == startPage {
                view?.showLoader()
            } else {
                view?.showLoadMore()
            }
            
        case .loaded(let photosInfo):
            if currentPage == startPage {
                retryCount = 0
                view?.hideLoader()
            } else {
                view?.hideLoadMore()
            }
            view?.addPhotos(photos: photosInfo)
            
        case .failed(_),
             .cancelled:
            if currentPage == startPage {
                view?.hideLoader()
                view?.showErrorView(isNeedRetryButton: retryCount < maximumRetryCount)
            } else {
                view?.removeLoadMore()
            }
        }
    }
}
