//
//  MapRouter.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit

protocol MapRoutingLogic { }

protocol MapDataPassing {
    var dataStore: MapDataStore { get }
}

final class MapRouter: MapRoutingLogic, MapDataPassing {
    private weak var viewController: UIViewController?
    let dataStore: MapDataStore
    
    init(viewController: UIViewController,
         dataStore: MapDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}
