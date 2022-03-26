//
//  GeocodingResponse.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

struct ReverseGeocodingResponse {
    
    enum Status: String {
        case ok = "OK"
        case zeroResults = "ZERO_RESULTS"
        case overQueryLimit = "OVER_QUERY_LIMIT"
        case requestDenied = "REQUEST_DENIED"
        case invalidRequest = "INVALID_REQUEST"
        case unknownError = "UNKNOWN_ERROR"
    }
    
    let city: String?
    let street: String?
    let streetNumber: String?
    let country: String?
    let postalCode: String?
    let status: Status
}
