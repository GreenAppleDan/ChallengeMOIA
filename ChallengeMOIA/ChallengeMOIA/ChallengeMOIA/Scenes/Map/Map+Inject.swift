//
//  Map+Inject.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import Swinject

extension Container {
    func mapDependencyInjectionContainer() {
        
        register(MapInteractor.self) { resolver in
            
            let presenter = resolver.resolveOrFatal(MapPresenter.self)
            let geocodingService = resolver.resolveOrFatal(GeocodingService.self)
            let interactor = MapInteractor(
                presenter: presenter,
                geocodingService: geocodingService)
            return interactor
        }
        
        register(MapPresenter.self) { resolver in
            let viewController = resolver.resolveOrFatal(MapViewController.self)
            let presenter = MapPresenter(viewController: viewController)
            return presenter
        }
        
        register(MapRouter.self) { resolver in
            let viewController = resolver.resolveOrFatal(MapViewController.self)
            let dataStore = resolver.resolveOrFatal(MapInteractor.self)
            let router = MapRouter(
                viewController: viewController,
                dataStore: dataStore)
            
            return router
        }
        
        register(MapViewController.self) { resolver in
            let viewController = MapViewController()
            return viewController
        }.initCompleted { resolver, viewController in
            viewController.interactor = resolver.resolve(MapInteractor.self)
            viewController.router = resolver.resolve(MapRouter.self)
        }
    }
}
