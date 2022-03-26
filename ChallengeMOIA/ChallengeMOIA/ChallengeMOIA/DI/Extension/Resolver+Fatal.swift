//
//  Resolver+Fatal.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Swinject

extension Resolver {
    func resolveOrFatal<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = resolve(serviceType) else {
            let selfDescription = String(describing: serviceType)
            fatalError("\(selfDescription) dependency could not be resolved")
        }
        
        return service
    }
}
