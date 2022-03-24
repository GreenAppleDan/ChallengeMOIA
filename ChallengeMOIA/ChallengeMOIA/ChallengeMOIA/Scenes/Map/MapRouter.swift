//
//  MapRouter.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit

protocol MapRoutingLogic { }

protocol MapDataPassing {
    var dataStore: MapDataStore? { get }
}

final class MapRouter: MapRoutingLogic, MapDataPassing {
    weak var viewController: UIViewController?
    var dataStore: MapDataStore?
}
