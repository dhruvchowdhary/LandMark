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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Get Location") {
                getLocation()
            }
        }
        .padding()
    }
    
    func getLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            userLocation = locationManager.location?.coordinate
            print("Latitude: \(userLocation?.latitude ?? 0), Longitude: \(userLocation?.longitude ?? 0)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

