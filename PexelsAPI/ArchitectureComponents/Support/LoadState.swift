//
//  LoadState.swift
//  PexelsAPI
//
//  Created by Vitaliy on 02.02.2021.
//

/// Состояние загрузки
///
/// Добавлен протокол Equatable, чтобы можно было сравнивать экземпляры дженерик-перечисления.
///
/// При проверке равенства не учитывается содержание связанных значений.

enum LoadState<T>: Equatable {
    case undefined
    case loading
    case loaded(_ result: T)
    case failed(_ error: ApiError)
    case cancelled
    
    /// associated value does't affect the result
    static func == (lhs: LoadState<T>, rhs: LoadState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.undefined, .undefined),
             (.loading, .loading),
             (.loaded, .loaded),
             (.failed, .failed),
             (.cancelled, .cancelled):
            return true
        default:
            return false
        }
    }
}
