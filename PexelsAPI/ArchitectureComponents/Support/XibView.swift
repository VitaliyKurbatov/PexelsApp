//
//  XibView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 25.02.2021.
//

import UIKit

/// Класс для создания вью из xib файла.
///
/// Важно! В xib файле в разделе identity inspector необходимо установить ваш "CustomClass" в качестве File's owner.
/// При этом класс самой вью оставить дефолтным, т.е. UIView.
@IBDesignable
class XibView: UIView {
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContent()
    }
    
    private func setupContent() {
        guard let xibView = loadViewFromXib() else {
            fatalError("Cannot init \(String(describing: type(of: self)))")
        }
        frame = xibView.frame
        contentView = xibView
        pinSubview(contentView)
        didLoadView()
    }
    
    private func loadViewFromXib() -> UIView? {
        let viewType = type(of: self)
        let bundle = Bundle(for: viewType)
        let className = String(describing: viewType)
        
        guard bundle.path(forResource: className, ofType: "nib") != nil else {
            return nil
        }
        let nib = UINib(nibName: className, bundle: bundle)
        let nibContent = nib.instantiate(withOwner: self, options: nil)
        
        return nibContent.first as? UIView
    }
    
    func didLoadView() {
        // method for override
    }
}

