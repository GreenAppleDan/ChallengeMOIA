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
    
    // Currently visible marker
    private var currentMarker: GMSMarker?
    
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
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    private func addNewMarker(at coordinate: CLLocationCoordinate2D) {
        removeCurrentMarker()
        
        let marker = GMSMarker(position: coordinate)
        marker.icon = .mapLocationMarker
        marker.appearAnimation = .pop
        marker.map = mapView
        currentMarker = marker
    }
    
    private func removeCurrentMarker() {
        currentMarker?.map = nil
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        addNewMarker(at: coordinate)
    }
}
