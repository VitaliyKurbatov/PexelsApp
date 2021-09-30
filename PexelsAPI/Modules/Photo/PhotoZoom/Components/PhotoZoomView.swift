//
//  PhotoZoomView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 14.04.2021.
//

import UIKit

final class PhotoZoomView: UIView, UIScrollViewDelegate {
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    var imageHeightConstraint: NSLayoutConstraint!
    
    lazy var closeButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.widthAnchor.constraint(equalToConstant: 32).isActive = true
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.pinSubview(imageView)
        imageView.image = UIImage(named: "circle_close")
        return view
    }()
    
    var closeTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .black
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        scrollView.addSubview(imageView)
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 400)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -UIApplication.shared.statusBarFrame.height),
            imageView.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerYAnchor),
            imageHeightConstraint
        ])
        
        addSubview(closeButtonView)
        NSLayoutConstraint.activate([
            closeButtonView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func setupGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCloseTapped(_:)))
        closeButtonView.addGestureRecognizer(tapRecognizer)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleCloseTapped(_:)))
        swipeRecognizer.direction = .down
        scrollView.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleCloseTapped(_ recognizer: UIPinchGestureRecognizer) {
        closeTapped?()
    }
    
    @objc private func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            zoomToPoint(recognizer.location(in: recognizer.view), scale: 2)
        } else {
            zoomToPoint(center, scale: 1)
        }
    }
    
    private func zoomToPoint(_ point: CGPoint, scale: CGFloat) {
        scrollView.zoom(
            to: calculateScaledRectForView(imageView,
                                           scale: scale,
                                           center: point),
            animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
