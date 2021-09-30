//
//  UIViewController.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import UIKit

extension UIViewController {
    
    func addChildVC(_ vc: UIViewController) {
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(vc)
        view.addSubview(vc.view)
    }
    
    func removeChildVC(_ vc: UIViewController) {
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        backButton.tintColor = ColorPalette.shared.blackMutable
        navigationItem.backBarButtonItem = backButton
    }
}
