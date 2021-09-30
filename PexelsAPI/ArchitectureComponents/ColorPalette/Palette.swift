//
//  Palette.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//

import UIKit

protocol Palette: AnyObject {
    var blackMutable: UIColor { get }
    var whiteMutable: UIColor { get }
}
