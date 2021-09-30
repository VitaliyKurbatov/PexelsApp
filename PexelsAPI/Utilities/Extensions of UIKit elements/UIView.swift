//
//  UIView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 25.01.2021.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func pinSubview(_ subview: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }
    
    func pinSubviewToCenter(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func calculateScaledRectForView(_ view: UIView, scale: CGFloat, center: CGPoint) -> CGRect {
        var newRect = CGRect.zero
        newRect.size.height = view.frame.size.height / scale
        newRect.size.width = view.frame.size.width / scale
        let newCenter = convert(center, from: view)
        newRect.origin.x = newCenter.x - (newRect.size.width / 2.0)
        newRect.origin.y = newCenter.y - (newRect.size.height / 2.0)
        return newRect
    }
}
