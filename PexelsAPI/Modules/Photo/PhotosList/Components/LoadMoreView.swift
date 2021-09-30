//
//  LoadMoreView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 08.02.2021.
//

import UIKit

final class LoadMoreView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        return indicator
    }()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pinSubviewToCenter(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
