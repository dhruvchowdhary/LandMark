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
    
    var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Latitude: \(latitude), Longitude: \(longitude)")
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
            latitude = userLocation?.latitude ?? 0
            longitude = userLocation?.longitude ?? 0
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

