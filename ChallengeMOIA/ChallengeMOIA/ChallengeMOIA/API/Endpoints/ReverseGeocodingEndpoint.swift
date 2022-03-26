//
//  ReverseGeocodingEndpoint.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

struct ReverseGeocodingEndpoint: BaseEndpoint {
    
    typealias Content = ReverseGeocodingResponse
    
    let latitude: Double
    let longitude: Double
    
    func makeRequest() throws -> URLRequest {
        guard let url = BaseUrlType.maps.baseUrlWith("api/geocode/json") else {
            throw URLError(.badURL)
        }
        
        var queryItems = [URLQueryItem]()
        
        // Latitude and longitude
        let latlng = [latitude, longitude].map{String($0)}.joined(separator: ",")
        queryItems.append(.init(name: "latlng", value: latlng))
        
        // key
        let key = ApiKeyStorage.googleMapsApiKey
        queryItems.append(.init(name: "key", value: key))
        
        // hardcoded filters
        let streetAddress = "street_address"
        let country = "country"
        let postalCode = "postal_code"
        let city = "locality"
        
        let resultTypes = [streetAddress, country, postalCode, city].joined(separator: "|")
        queryItems.append(.init(name: "result_type", value: resultTypes))
        
        let finalUrl = try url.appendingQueryItems(queryItems)
        return .get(finalUrl)
    }
}
