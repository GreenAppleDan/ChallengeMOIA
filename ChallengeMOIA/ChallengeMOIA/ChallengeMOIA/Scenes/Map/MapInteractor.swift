//
//  MapInteractor.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

protocol MapBusinessLogic { }

protocol MapDataStore { }

final class MapInteractor: MapBusinessLogic, MapDataStore {
  var presenter: MapPresentationLogic?
}
