//
//  MapPresenter.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
// 

protocol MapPresentationLogic {
    func presentReverseGeocode(response: FetchReverseGeocode.Response)
}

final class MapPresenter: MapPresentationLogic {
    
    private weak var viewController: MapDisplayLogic?
    
    init(viewController: MapDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentReverseGeocode(response: FetchReverseGeocode.Response) {
    }
}
