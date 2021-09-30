//
//  DataUnits.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//

import Foundation

enum DataUnits: String {
    case kilobyte = "KB"
    case megabyte = "MB"
    
    static let KB = 1024        // 1 KB (1024 bytes)
    static let MB = KB * 1024   // 1 MB = 1 KB * 1024
}
