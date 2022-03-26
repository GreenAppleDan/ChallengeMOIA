//
//  MapInteractor.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import Foundation

protocol MapBusinessLogic {
    func fetchReverseGeocode(request: FetchReverseGeocode.Request)
}

protocol MapDataStore { }

final class MapInteractor: MapBusinessLogic, MapDataStore {
    
    private let presenter: MapPresentationLogic
    private let geocodingService: GeocodingService
    
    private var currentReverseGeocodeProgress: Progress?
    
    init(presenter: MapPresentationLogic,
         geocodingService: GeocodingService) {
        self.presenter = presenter
        self.geocodingService = geocodingService
    }
    
    func fetchReverseGeocode(request: FetchReverseGeocode.Request) {
        // canceling previous request if still running
        currentReverseGeocodeProgress?.cancel()
        
        currentReverseGeocodeProgress = geocodingService.reverseGeocode(
            latitude: request.latitude,
            longitude: request.longitude) { [weak self] result in
                switch result {
                case .success(let geocodingResponse):
                    self?.processReverseGeocodeSuccess(response: geocodingResponse)
                case .failure:
                    let response = FetchReverseGeocode.Response.failure(errorText: "Error. Please try again later")
                    self?.presenter.presentReverseGeocode(response: response)
                }
            }
    }
    
    // MARK: Private
    private func processReverseGeocodeSuccess(response: ReverseGeocodingResponse) {
        if let errorText = errorTextFromGeocodingResponseStatus(response.status) {
            let response = FetchReverseGeocode.Response.failure(errorText: errorText)
            presenter.presentReverseGeocode(response: response)
            return
        }
        
        let responseData = reverseGeocodeResponseDataFrom(response: response)
        let response = FetchReverseGeocode.Response.success(response: responseData)
        presenter.presentReverseGeocode(response: response)
    }
    
    private func reverseGeocodeResponseDataFrom(response: ReverseGeocodingResponse) -> FetchReverseGeocode.ResponseData {
        var city: String?
        var street: String?
        var streetNumber: String?
        var country: String?
        var postalCode: String?
        
        if let addressComponents = response.results.first?.addressComponents {
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
                     postalCode: postalCode)
    }
    
    private func errorTextFromGeocodingResponseStatus(_ status: ReverseGeocodingResponseStatus) -> String? {
        switch status {
        case .ok:
            return nil
        case .zeroResults:
            return "This location does not produce any results"
        default:
            return "Unknown error"
        }
    }
}
