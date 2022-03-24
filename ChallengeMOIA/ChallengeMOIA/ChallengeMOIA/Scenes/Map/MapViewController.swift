//
//  MapViewController.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit

protocol MapDisplayLogic: AnyObject { }

final class MapViewController: UIViewController, MapDisplayLogic {
    var interactor: MapBusinessLogic?
    var router: (MapRoutingLogic & MapDataPassing)?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
