//
//  Services+Inject.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Swinject

extension Container {
    func serviceDependencyInjectionContainer() {
        
        register(APIClient.self) { _ in
            Client()
        }
        
        register(GeocodingService.self) { resolver in
            let apiClient = resolver.resolveOrFatal(APIClient.self)
            return BaseGeocodingService(apiClient: apiClient)
        }
    }
}
