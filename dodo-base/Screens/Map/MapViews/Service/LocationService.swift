//
//  LocationService.swift
//  UIKitHomework
//
//  Created by Andrew on 02.09.2025.
//

import UIKit
import CoreLocation


class LocationService: NSObject {
    
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    private var onLocationFetched: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}


//MARK: - Public
extension LocationService {
    
    func fetchCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        locationManager.startUpdatingLocation()
        onLocationFetched = completion
    }
}


extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
            
        case .authorizedAlways:
            print("When user select option Allow While Using App or Allow O")
        case .authorizedWhenInUse:
            print("When user select option Allow While Using App or Allow O")

        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
        locationManager.stopUpdatingLocation()
        
        onLocationFetched?(location)
    }
}
