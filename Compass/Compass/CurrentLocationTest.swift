//
//  CurrentLocationTest.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

import Foundation
import CoreLocation

let locationManager = CLLocationManager()


//locationManager.delegate = self;
////Get's location once
//locationManager.requestLocation()


func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
) {
    if let location = locations.first {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let altitude = location.altitude
        print(latitude, longitude, altitude)
        // Handle location update
    }
}

//Handles error case -- cant find location for some reason!
func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
) {
    // Handle failure to get a user’s location
    //some kind of pop up maybe like try again
}


// gotta request location yk
//locationManager.requestAlwaysAuthorization()

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
