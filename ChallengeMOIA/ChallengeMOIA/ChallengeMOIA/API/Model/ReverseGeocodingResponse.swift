//
//  ReverseGeocodingResponse.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

struct ReverseGeocodingResponse: Decodable {
    let results: [GeocodingAddressesContainer]
    let status: ReverseGeocodingResponseStatus
}

struct GeocodingAddressesContainer: Decodable {
    let addressComponents: [GeocodingAddressComponent]
}

struct GeocodingAddressComponent: Decodable {
    let longName: String
    // Types is string instead of enum. This is done this way cas otherwise it would be overhead since I would have to cover every single case (and I need only 5)
    let types: [String]
}

enum ReverseGeocodingResponseStatus: String, Decodable {
    case ok = "OK"
    case zeroResults = "ZERO_RESULTS"
    case overQueryLimit = "OVER_QUERY_LIMIT"
    case requestDenied = "REQUEST_DENIED"
    case invalidRequest = "INVALID_REQUEST"
    case unknownError = "UNKNOWN_ERROR"
}
