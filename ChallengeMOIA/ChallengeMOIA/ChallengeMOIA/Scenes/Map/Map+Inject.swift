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
            let interactor = MapInteractor()
            interactor.presenter = resolver.resolve(MapPresenter.self)
            return interactor
        }
        
        register(MapPresenter.self) { resolver in
            let presenter = MapPresenter()
            presenter.viewController = resolver.resolve(MapViewController.self)
            return presenter
        }
        
        register(MapRouter.self) { resolver in
            let router = MapRouter()
            router.viewController = resolver.resolve(MapViewController.self)
            router.dataStore = resolver.resolve(MapInteractor.self)
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
