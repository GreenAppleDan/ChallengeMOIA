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
    
    enum Response {
        case success(response: ReverseGeocodingResponse)
        case failure(error: Error)
    }
    
    enum ViewModel {
        case success(title: String, subtitle: String)
        case failure(errorText: String)
    }
}
