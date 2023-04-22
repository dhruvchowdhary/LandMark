import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {

    @State private var userLocation: CLLocationCoordinate2D?
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var currLatitude: Double = 0
    @State private var currLongitude: Double = 0
    @State private var userHeading: Double = 0.0
    let motionManager = CMMotionManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Latitude: \(latitude), Longitude: \(longitude)")
            Text("Current Location: \(currLatitude), \(currLongitude)")
            Text("Rotation: \(userHeading)")
            Button("Get Location") {
                getLocation()
            }
        }
        .padding()
        .onAppear() {
            updateLocation()
            motionManager.startDeviceMotionUpdates()
            motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
                guard let motion = motion else { return }
                let attitude = motion.attitude
                userHeading = attitude.yaw * 180 / .pi
                print(userHeading)
            }
        }
        .onDisappear() {
            motionManager.stopDeviceMotionUpdates()
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
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                let currLocation = locationManager.location?.coordinate
                currLatitude = currLocation?.latitude ?? 0
                currLongitude = currLocation?.longitude ?? 0
            }
        }
        timer.fire()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
