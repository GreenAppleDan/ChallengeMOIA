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
        
        switch response {
        case .success(let responseData):
            let viewModel = reverseGeocodeViewModelFromResponseData(responseData: responseData)
            viewController?.displayReverseGeocode(viewModel: viewModel)
        case .failure(let errorText):
            viewController?.displayReverseGeocode(viewModel: .failure(errorText: errorText))
        }
    }
    
    private func reverseGeocodeViewModelFromResponseData(responseData: FetchReverseGeocode.ResponseData) -> FetchReverseGeocode.ViewModel {
        
        let title = [responseData.street, responseData.streetNumber].compactMap{ $0 }.joined(separator: " ")
        
        let cityString: String
        
        if let city = responseData.city {
            cityString = city + ","
        } else {
            cityString = ""
        }
        
        let subtitle = [responseData.postalCode, cityString, responseData.country].compactMap{ $0 }.joined(separator: " ")
        
        if title.isEmpty {
            return .success(title: subtitle, subtitle: "")
        }
        
        return .success(title: title, subtitle: subtitle)
    }
}
