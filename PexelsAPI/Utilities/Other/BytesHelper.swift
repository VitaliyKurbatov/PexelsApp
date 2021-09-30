//
//  BytesHelper.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//

import Foundation

enum BytesHelper {
    /// создает удобночитаемый текст вида "2.4 MB"
    static func getFileSize(bytes: UInt) -> String {
        if getSize(bytes: bytes, in: .megabyte) >= 1.0 {
            return getSizeText(bytes: bytes, in: .megabyte)
        }
        return getSizeText(bytes: bytes, in: .kilobyte)
    }
    
    static func getSize(bytes: UInt, in type: DataUnits) -> Double {
        var size: Double
        
        switch type {
        case .kilobyte:
            size = Double(bytes) / Double(DataUnits.KB)
        case .megabyte:
            size = Double(bytes) / Double(DataUnits.MB)
        }
        
        return size
    }
    
    static func getSizeText(bytes: UInt, in type: DataUnits) -> String {
        let size = getSize(bytes: bytes, in: type)
        var text: String
        
        switch type {
        case .kilobyte:
            let kb = Int(size.rounded())
            text = String(kb)
        case .megabyte:
            let mb = round(size * 10) / 10
            text = Decimal(mb).description
        }

        return text + " \(type.rawValue)"
    }
}
