//
//  ReverseGeocodingEndpoint.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

private enum ReverseGeocodingError: LocalizedError {
    case zeroResults
    
    var errorDescription: String? {
        switch self {
        case .zeroResults:
            return "This location does not produce any results"
        }
    }
    
   static func errorFrom(status: ReverseGeocodingResponse.Status) -> Error? {
        switch status {
        case .ok:
            return nil
        case .zeroResults:
            return Self.zeroResults
        default:
            return BaseError.unknown
        }
    }
}

private struct GeocodingAddressComponent: Decodable {
    let longName: String
    let types: [String]
}

struct ReverseGeocodingEndpoint: Endpoint {
    
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
    
    func content(from response: URLResponse?, with body: Data) throws -> ReverseGeocodingResponse {
        guard let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String : Any] else {
            throw URLError(.badServerResponse)
        }
        
        let rawStatus = (json["status"] as? String) ?? ""
        guard let status = ReverseGeocodingResponse.Status(rawValue: rawStatus) else {
            throw URLError(.badServerResponse)
        }
        
        try validateStatus(status: status)
        
        var city: String?
        var street: String?
        var streetNumber: String?
        var country: String?
        var postalCode: String?
        
        if let rawAddressComponents = try? JSONSerialization.data(withJSONObject: json["address_components"] ?? [:]),
           let addressComponents = try? JSONDecoder.default.decode([GeocodingAddressComponent].self, from: rawAddressComponents) {
            for addressComponent in addressComponents {
                let types = addressComponent.types
                let longName = addressComponent.longName
                
                // City
                if types.contains("locality") {
                    city = longName
                }
                // Street
                else if types.contains("route") {
                    street = longName
                }
                // Street number
                else if types.contains("street_number") {
                    streetNumber = longName
                }
                // Country
                else if types.contains("country") {
                    country = longName
                }
                // Postal code
                else if types.contains("postal_code") {
                    postalCode = longName
                }
                
            }
        }
        
        
        return .init(city: city,
                     street: street,
                     streetNumber: streetNumber,
                     country: country,
                     postalCode: postalCode,
                     status: status)
    }
    
    private func validateStatus(status: ReverseGeocodingResponse.Status) throws {
        if let error = ReverseGeocodingError.errorFrom(status: status) {
            throw error
        }
    }
}
