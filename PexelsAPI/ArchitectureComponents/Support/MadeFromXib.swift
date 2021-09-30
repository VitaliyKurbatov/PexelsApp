//
//  MadeFromXib.swift
//  PexelsAPI
//
//  Created by Vitaliy on 06.05.2021.
//

/// Требование указать, как создан объект: из xib файла или программно
protocol MadeFromXib: AnyObject {
    static var isMadeFromXib: Bool { get }
}
