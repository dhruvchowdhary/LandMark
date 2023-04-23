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
    @State private var recentLocations: Array = []
    @State private var counter: Int = 0

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
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
//            if CLLocationManager.locationServicesEnabled() {
                let currLocation = locationManager.location?.coordinate
                currLatitude = currLocation?.latitude ?? 0.0
                currLongitude = currLocation?.longitude ?? 0.0
                
                angleFromNorth = self.compassHeading.degrees * -1

                let bearing = angleBetweenTwoLocations(fromLat: currLatitude, fromLong: currLongitude, toLat: setLatitude, toLong: setLongitude)
                
                let theta = bearing - angleFromNorth
                if theta < 0 {
                    arrowAngle = theta + 360
                } else {
                    arrowAngle = theta
                }
//            }
            
            counter += 1
            if counter % 5 == 0 {
                recentLocations.append((currLatitude, currLongitude))
            }
        }
        timer.fire()
    }
    
    func angleBetweenTwoLocations(fromLat: Double, fromLong: Double, toLat: Double, toLong: Double) -> Double {
        let fromLatRad = fromLat.degreesToRadians
        let fromLongRad = fromLong.degreesToRadians

        let toLatRad = toLat.degreesToRadians
        let toLongRad = toLong.degreesToRadians

        let dLon = toLongRad - fromLongRad

        let y = sin(dLon) * cos(toLatRad)
        let x = cos(fromLatRad) * sin(toLatRad) - sin(fromLatRad) * cos(toLatRad) * cos(dLon)

        let degBearing = atan2(y, x).radiansToDegrees
        
        if (degBearing >= 0) {
            return degBearing
        } else {
            return 360 + degBearing
        }
    }
}

private extension Double {
    var degreesToRadians: Double { return self * (.pi / 180) }
    var radiansToDegrees: Double { return self * (180 / .pi) }
}


