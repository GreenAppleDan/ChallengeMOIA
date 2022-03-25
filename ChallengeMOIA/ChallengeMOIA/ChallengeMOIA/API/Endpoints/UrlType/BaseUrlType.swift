//
//  BaseUrlType.swift
//  ChallengeMOIA
//
//  Created by Denis on 25.03.2022.
//

import Foundation

enum BaseUrlType {
    case maps
    
    private var baseUrlString: String {
        switch self {
        case .maps:
            return "https://maps.googleapis.com/maps/"
        }
    }
    
    func baseUrlWith(_ string: String) -> URL? {
        URL(string: baseUrlString + string)
    }
}
