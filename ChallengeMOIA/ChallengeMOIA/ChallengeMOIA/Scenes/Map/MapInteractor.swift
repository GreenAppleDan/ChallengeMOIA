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
                    let response = FetchReverseGeocode.Response.success(response: geocodingResponse)
                    self?.presenter.presentReverseGeocode(response: response)
                case .failure(let error):
                    let response = FetchReverseGeocode.Response.failure(error: error)
                    self?.presenter.presentReverseGeocode(response: response)
                }
            }
    }
}
