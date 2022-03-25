//
//  MapViewController.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit
import GoogleMaps

protocol MapDisplayLogic: AnyObject { }

final class MapViewController: UIViewController, MapDisplayLogic {
    var interactor: MapBusinessLogic?
    var router: (MapRoutingLogic & MapDataPassing)?
    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 53.5499242, longitude: 9.9839786, zoom: 15.0)
        return GMSMapView(frame: view.bounds, camera: camera)
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureMap()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        mapView.frame.size = size
    }
    
    // MARK: Private
    private func configureView() {
        view.backgroundColor = .background
    }
    
    private func configureMap() {
        view.addSubview(mapView)
    }
    
}
