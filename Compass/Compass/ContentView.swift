//
//  ContentView.swift
//  Compass
//
//  Created by Rohan Taneja on 4/22/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var currLatitude: Double = 0
    @State private var currLongitude: Double = 0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Latitude: \(latitude), Longitude: \(longitude)")
            Text("Current Location: \(currLatitude), \(currLongitude)")
            Button("Get Location") {
                getLocation()
            }
        }
        .padding()
        .onAppear() {
            updateLocation()
        }
    }
    
    func getLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            userLocation = locationManager.location?.coordinate
            UserDefaults.standard.set(userLocation?.latitude ?? 0, forKey: "setLatitude")
            UserDefaults.standard.set(userLocation?.longitude ?? 0, forKey: "setLongitude")
            latitude = Double(UserDefaults.standard.double(forKey: "setLatitude"))
            longitude = Double(UserDefaults.standard.double(forKey: "setLongitude"))
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
    
    func updateLocation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                let currLocation = locationManager.location?.coordinate
                currLatitude = currLocation?.latitude ?? 0
                currLongitude = currLocation?.longitude ?? 0
            }
            getBearing(lat1: UserDefaults.standard.double(forKey: "setLatitude"), lon1: UserDefaults.standard.double(forKey: "setLongitude"), lat2: currLatitude, lon2: currLongitude)
        }
        timer.fire()
    }
    
    func getBearing(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        var radiansBearing = atan2(y, x)
        if radiansBearing < 0 {
            radiansBearing += 2 * Double.pi
        }
        print(radiansBearing.radiansToDegrees)

        return radiansBearing.radiansToDegrees
    }
    
    
}
extension Double {
    var radiansToDegrees: Double {
        return self * 180.0 / Double.pi
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
