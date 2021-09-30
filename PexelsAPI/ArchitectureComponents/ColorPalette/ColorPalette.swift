//
//  ColorPalette.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//

import UIKit

final class ColorPalette: Palette {
    static var shared: Palette = {
        do {
            return try ColorPalette()
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    var blackMutable: UIColor
    var whiteMutable: UIColor
    
    private init() throws {
        blackMutable = try ColorPalette.color(named: "blackMutable")
        whiteMutable = try ColorPalette.color(named: "whiteMutable")
    }

    private static func color(named name: String) throws -> UIColor {
        guard let colorFromAssets = UIColor(named: "ColorPalette/\(name)") else {
            throw ColorAssetError.cannotFindAsset(named: "ColorPalette/\(name)")
        }
        return colorFromAssets
    }
    
    enum ColorAssetError: LocalizedError {
        case cannotFindAsset(named: String)
        
        var errorDescription: String? {
            switch self {
            case .cannotFindAsset(let color):
                return NSLocalizedString("Cannot find asset named \"\(color)\"", comment: "")
            }
        }
    }
}
