//
//  MapModels.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

enum FetchReverseGeocode {
    struct Request {
        let latitude: Double
        let longitude: Double
    }
    
    struct ResponseData {
        let city: String?
        let street: String?
        let streetNumber: String?
        let country: String?
        let postalCode: String?
    }
    
    enum Response {
        case success(response: ResponseData)
        case failure(errorText: String)
    }
    
    enum ViewModel {
        case success(title: String, subtitle: String)
        case failure(errorText: String)
    }
}
