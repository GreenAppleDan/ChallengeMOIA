//
//  MapInteractor.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

protocol MapBusinessLogic { }

protocol MapDataStore { }

final class MapInteractor: MapBusinessLogic, MapDataStore {
    private let presenter: MapPresentationLogic
    private let geocodingService: GeocodingService
    
    init(presenter: MapPresentationLogic,
         geocodingService: GeocodingService) {
        self.presenter = presenter
        self.geocodingService = geocodingService
    }
}
