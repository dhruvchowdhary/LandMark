import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {
    
    @ObservedObject var compassHeading = CompassHeading()

    @State private var setLocation: CLLocationCoordinate2D?
    @State private var setLatitude: Double = 0
    @State private var setLongitude: Double = 0
    @State private var currLatitude: Double = 0
    @State private var currLongitude: Double = 0
    @State private var userHeading: Double = 0.0
    @State private var angleFromNorth: Double = 0.0
    @State private var arrowAngle: Double = 0.0
    let angleCalculator = AngleCalculator()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Latitude: \(setLatitude), Longitude: \(setLongitude)")
            Text("Current Location: \(currLatitude), \(currLongitude)")
//            Text("Rotation: \(userHeading)")
            Text("Degrees from North: \(angleFromNorth)")
            Text("Arrow Angle: \(arrowAngle)")
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
            setLocation = locationManager.location?.coordinate
            setLatitude = setLocation?.latitude ?? 0.0
            setLongitude = setLocation?.longitude ?? 0.0
            UserDefaults.standard.set(setLatitude, forKey: "setLatitude")
            UserDefaults.standard.set(setLongitude, forKey: "setLongitude")
//            currLocation = locationManager.location?.coordinate
//            currLatitude = Double(UserDefaults.standard.float(forKey: "setLatitude"))
//            currLongitude = Double(UserDefaults.standard.float(forKey: "setLongitude"))
            print("Latitude: \(setLatitude), Longitude: \(setLongitude)")
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
                currLatitude = Double(UserDefaults.standard.float(forKey: "setLatitude"))
                currLongitude = Double(UserDefaults.standard.float(forKey: "setLongitude"))
                
                let userLocation = locationManager.location?.coordinate
                angleFromNorth = self.compassHeading.degrees
                let angleToGoal = angleBetweenTwoLocations(fromLat: userLocation?.latitude ?? 0.0, fromLong: userLocation?.longitude ?? 0.0, toLat: setLatitude ?? 0.0, toLong: setLongitude ?? 0.0)
                arrowAngle = angleToGoal - angleFromNorth
            }
        }
        timer.fire()
    }
    
    func angleBetweenTwoLocations(fromLat: Double, fromLong: Double, toLat: Double, toLong: Double) -> Double {
        let deltaLongitude = toLong - fromLong
        let y = sin(deltaLongitude) * cos(toLat)
        let x = cos(fromLat) * sin(toLat) - sin(fromLat) * cos(toLat) * cos(deltaLongitude)
        let radians = atan2(y, x)
        let degrees = radians * 180 / .pi
        return degrees
    }
}


