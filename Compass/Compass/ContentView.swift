import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {
    
    @ObservedObject var compassHeading = CompassHeading()

    @State private var userLocation: CLLocationCoordinate2D?
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var currLatitude: Double = 0
    @State private var currLongitude: Double = 0
    @State private var userHeading: Double = 0.0
    @State private var angle: Double = 0.0
    let angleCalculator = AngleCalculator()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Latitude: \(latitude), Longitude: \(longitude)")
            Text("Current Location: \(currLatitude), \(currLongitude)")
//            Text("Rotation: \(userHeading)")
            Text("Degrees from North: \(angle)")
            Button("Set Location") {
                getLocation()
            }
        }
        .padding()
        .onAppear {
            updateLocation()
        }
    }

    func getLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            userLocation = locationManager.location?.coordinate
            UserDefaults.standard.set(userLocation?.latitude ?? 0, forKey: "setLatitude")
            UserDefaults.standard.set(userLocation?.longitude ?? 0, forKey: "setLongitude")
            latitude = Double(UserDefaults.standard.float(forKey: "setLatitude"))
            longitude = Double(UserDefaults.standard.float(forKey: "setLongitude"))
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }

    func updateLocation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
                locationManager.startUpdatingHeading()
                let currLocation = locationManager.location?.coordinate
                currLatitude = currLocation?.latitude ?? 0
                currLongitude = currLocation?.longitude ?? 0
                
//                if let heading = locationManager.heading?.trueHeading {
//                    userHeading = locationManager.heading?.trueHeading
//                }
                
//                let targetLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                angle = angleCalculator.computeAngle(from: currLocation ?? CLLocationCoordinate2D(), to: targetLocation, with: self.compassHeading.degrees)
                
                angle = self.compassHeading.degrees
            }
        }
        timer.fire()
    }
    
    func angleBetweenTWoLocations(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let deltaLongitude = to.longitude - from.longitude
        let y = sin(deltaLongitude) * cos(to.latitude)
        let x = cos(from.latitude) * sin(to.latitude) - sin(from.latitude) * cos(to.latitude) * cos(deltaLongitude)
        let radians = atan2(y, x)
        let degrees = radians * 180 / .pi
        return degrees
    }
    
    

}


