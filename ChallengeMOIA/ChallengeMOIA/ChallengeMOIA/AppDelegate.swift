//
//  AppDelegate.swift
//  ChallengeMOIA
//
//  Created by Denis on 24.03.2022.
//

import UIKit
import Swinject
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setGoogleMapsApiKey()
        container.registerDependency()
        configureWindow()
        
        return true
    }
    
    private func setGoogleMapsApiKey() {
        GMSServices.provideAPIKey(ApiKeyStorage.googleMapsApiKey)
    }
    
    private func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container.resolve(MapViewController.self)
        window?.makeKeyAndVisible()
    }

}

