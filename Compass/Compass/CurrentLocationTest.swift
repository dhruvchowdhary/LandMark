//
//  CurrentLocationTest.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

import Foundation
import CoreLocation

let locationManager = CLLocationManager()


locationManager.delegate = self;
//Get's location once
locationManager.requestLocation()
//After using .request location location manager will be called

func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
) {
    if let location = locations.first {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print(latitude, longitude)
        // Handle location update
    }
}
//
//locationManager.desiredAccuracy = kCLLocationAccuracyBest
//locationManager.requestAlwaysAuthorization()
//locationManager.startUpdatingLocation()
//
//
//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//    print("locations = \(locValue.latitude) \(locValue.longitude)")
//}
//
