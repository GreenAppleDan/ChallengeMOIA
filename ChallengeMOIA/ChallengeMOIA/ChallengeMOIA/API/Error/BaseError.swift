//
//  BaseError.swift
//  ChallengeMOIA
//
//  Created by Denis on 25.03.2022.
//

import Foundation

enum BaseError: LocalizedError {
    case invalidUrl
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid url was passed"
        case .unknown:
            return "Unknown error"
        }
    }
}

