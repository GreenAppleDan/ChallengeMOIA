//
//  GeocodingService.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

protocol GeocodingService {
    func reverseGeocode(latitude: Double,
                 longitude: Double,
                 completion: @escaping ResultHandler<ReverseGeocodingResponse>) -> Progress
}

final class BaseGeocodingService: APIService, GeocodingService {
    func reverseGeocode(latitude: Double, longitude: Double, completion: @escaping ResultHandler<ReverseGeocodingResponse>) -> Progress {
        let endpoint = ReverseGeocodingEndpoint(
            latitude: latitude,
            longitude: longitude)
        
        return apiClient.request(endpoint, completionHandler: completion)
    }
}
