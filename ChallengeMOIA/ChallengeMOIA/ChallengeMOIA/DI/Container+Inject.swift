//
//  Container+Inject.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import Swinject

extension Container {
    func registerDependency() {
        mapDependencyInjectionContainer()
        serviceDependencyInjectionContainer()
    }
}
