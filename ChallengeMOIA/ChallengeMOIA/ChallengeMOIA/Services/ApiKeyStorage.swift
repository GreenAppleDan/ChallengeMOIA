//
//  ApiKeyStorage.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

enum ApiKeyStorage {
    static var googleMapsApiKey: String {
        let key = "API_KEY"
        
        guard let apiKey = Bundle.main.infoDictionary?[key] as? String else  {
            fatalError("Api key is not set")
        }
        
        return apiKey
    }
}
