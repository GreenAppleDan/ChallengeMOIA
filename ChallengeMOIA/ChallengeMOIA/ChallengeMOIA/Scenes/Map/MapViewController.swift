//
//  MapViewController.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit
import GoogleMaps

protocol MapDisplayLogic: AnyObject {
    func displayReverseGeocode(viewModel: FetchReverseGeocode.ViewModel)
}

final class MapViewController: UIViewController {
    
    var interactor: MapBusinessLogic?
    var router: (MapRoutingLogic & MapDataPassing)?
    
    // MARK: GMSMapView
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 53.5499242, longitude: 9.9839786, zoom: 15.0)
        return GMSMapView(frame: view.bounds, camera: camera)
    }()
    
    // Currently visible marker
    private var currentMarker: GMSMarker?
    
    // MARK: LocationDescriptionView
    private lazy var locationDescriptionView: LocationDescriptionView = {
        LocationDescriptionView { [weak self] in
            self?.removeCurrentMarker()
            self?.interactor?.cancelCurrentReverseGeocodingRequest()
            self?.changeLocationDescriptionVisibilityAnimated(isHidden: true) {
                self?.locationDescriptionView.stopLoading()
            }
        }
    }()
    
    // This constraint is active when locationDescriptionView is hidden, and inactive when locationDescriptionView is visible. Active by default
    private var descriptionViewTopToRootViewBottomConstraint: NSLayoutConstraint?
    // This constraint is active when locationDescriptionView is visible, and inactive when locationDescriptionView is hidden. Inactive by default
    private var descriptionViewBottomToRootViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureMap()
        addLocationDescriptionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mapView.frame.size = size
    }

    // MARK: Private
    private func configureView() {
        view.backgroundColor = .background
    }
    
    private func showError(errorText: String) {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: MapDisplayLogic
extension MapViewController: MapDisplayLogic {
    func displayReverseGeocode(viewModel: FetchReverseGeocode.ViewModel) {
        switch viewModel {
        case .success(let title, let subtitle):
            locationDescriptionView.update(titleText: title, subtitleText: subtitle)
            locationDescriptionView.stopLoading()
        case .failure(let errorText):
            showError(errorText: errorText)
            removeCurrentMarker()
            changeLocationDescriptionVisibilityAnimated(isHidden: true) { [weak self] in
                self?.locationDescriptionView.stopLoading()
            }
        }
    }
}

// MARK: GMSMapView Related
extension MapViewController {
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

// MARK: GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        addNewMarker(at: coordinate)
        
        // Showing location description view with animation and show loading indicator
        locationDescriptionView.startLoading()
        changeLocationDescriptionVisibilityAnimated(isHidden: false)
        
        interactor?.fetchReverseGeocode(request: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
}

// MARK: LocationDescriptionView Related
extension MapViewController {
    private func addLocationDescriptionView() {
        locationDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationDescriptionView)
        
        // Basic padding of locationDescriptionView, when it is visible, left, right and bottom padding will be applied, when it is hidden, left, right and top padding (to the bottom of root view) will be applied
        let locationDescriptionViewSidePadding: CGFloat = 20
        
        // Width is never changing and equals to the width of root view minus side padding (in portrait orientation)
        let locationDescriptionViewWidth = min(view.frame.width, view.frame.height) - 2 * locationDescriptionViewSidePadding
        
        // This constraint is active when locationDescriptionView is hidden, and inactive when locationDescriptionView is visible. Active by default
        let descriptionViewTopToRootViewBottomConstraint = locationDescriptionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: locationDescriptionViewSidePadding)
        
        // This constraint is active when locationDescriptionView is visible, and inactive when locationDescriptionView is hidden. Inactive by default
        let descriptionViewBottomToRootViewBottomConstraint = view.bottomAnchor.constraint(equalTo: locationDescriptionView.bottomAnchor, constant: locationDescriptionViewSidePadding)
        
        // there is no trailing anchor because when view rotates we want the locationDescriptionView to always stick to the left side
        NSLayoutConstraint.activate([
            locationDescriptionView.widthAnchor.constraint(equalToConstant: locationDescriptionViewWidth),
            locationDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: locationDescriptionViewSidePadding),
            descriptionViewTopToRootViewBottomConstraint
        ])
        
        self.descriptionViewTopToRootViewBottomConstraint = descriptionViewTopToRootViewBottomConstraint
        self.descriptionViewBottomToRootViewBottomConstraint = descriptionViewBottomToRootViewBottomConstraint
        
    }
    
    private func changeLocationDescriptionVisibilityAnimated(isHidden: Bool, onCompletion: (() -> Void)? = nil) {
        
        guard descriptionViewTopToRootViewBottomConstraint?.isActive != isHidden else {
            onCompletion?()
            return
        }
        
        descriptionViewTopToRootViewBottomConstraint?.isActive = isHidden
        descriptionViewBottomToRootViewBottomConstraint?.isActive = !isHidden
        layoutWithAnimation(onCompletion: onCompletion)
    }
    
    private func layoutWithAnimation(onCompletion: (() -> Void)?) {
        let animations: () -> Void = {
            self.view.layoutIfNeeded()
        }
        
        let completion: ((Bool) -> Void) = { _ in
            onCompletion?()
        }
        
        UIView.animate(withDuration: 0.3,
                       animations: animations,
                       completion: completion)
    }
}
