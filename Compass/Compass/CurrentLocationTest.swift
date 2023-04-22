//
//  CurrentLocationTest.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

import Foundation
import CoreLocation
import Math

let locationManager = CLLocationManager()


func getBearing(lat1, lat2, long1, long2) {
    let dLon = lon2 - lon1

    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

    var radiansBearing = atan2(y, x)
    if radiansBearing < 0 {
        radiansBearing += 2 * Double.pi
    }

    return radiansBearing.radiansToDegrees
}

func doComputeAngleBetweenMapPoints(
    fromHeading: CLLocationDirection,
    _ fromPoint: CLLocationCoordinate2D,
    _ toPoint: CLLocationCoordinate2D
) -> CLLocationDirection {
    let bearing = getBearing(point1: fromPoint, point2: toPoint)
    var theta = bearing - fromHeading
    if theta < 0 {
        theta += 360
    }
    return theta
}

func getDistance(lat1,lon1,lat2,lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2-lat1);  // deg2rad below
  var dLon = deg2rad(lon2-lon1);
  var a =
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
    Math.sin(dLon/2) * Math.sin(dLon/2)
    ;
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  var d = R * c; // Distance in km
  return d;
}

func deg2rad(deg) {
  return deg * (Math.PI/180)
}


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
