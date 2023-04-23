//
//  HomeView.swift
//  Compass
//
//  Created by Dhruv Chowdhary on 4/22/23.
//

import SwiftUI
import CoreLocation
import CoreMotion

struct HomeView: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarOffset: CGFloat = UIScreen.main.bounds.height * 0.53 // Initial position
    @State private var showPtImages: [Bool] = [false, false, false, false, false, false, false]
    // UserDefaults.standard.array(forKey: "showPtImages") as? [Bool] ??
    @State private var nextImageToShowIndex = 0
    // UserDefaults.standard.integer(forKey: "nextImageToShowIndex") ??
    @State private var inputText0 = ""
    @State private var inputText1 = ""
    @State private var inputText2 = ""
    @State private var inputText3 = ""
    @State private var inputText4 = ""
    @State private var inputText5 = ""
    @State private var inputText6 = ""
    
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
        ZStack {
            ZStack {
                Image("mountain-background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Image("Arrow")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.13)
                    .offset(y: -210)
                ZStack {
                    Image("compass2")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .rotationEffect(Angle(degrees: angleFromNorth))
                    if showPtImages[0] {
                                            Image("pt0")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 0))
                                        }
                    if showPtImages[1] {
                                            Image("pt1")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 40))
                                        }
                    if showPtImages[2] {
                                            Image("pt2")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 60))
                                        }
                    if showPtImages[3] {
                                            Image("pt3")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 80))
                                        }
                    if showPtImages[4] {
                                            Image("pt4")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 120))
                                        }
                    if showPtImages[5] {
                                            Image("pt5")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 200))
                                        }
                    if showPtImages[6] {
                                            Image("pt6")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -165)
                                                .rotationEffect(Angle(degrees: 300))
                                        }
                }
                Button(action: {
                    if nextImageToShowIndex < showPtImages.count {
                        
                                showPtImages[nextImageToShowIndex] = true
                                nextImageToShowIndex += 1
                                UserDefaults.standard.set(showPtImages, forKey: "showPtImages")
                                UserDefaults.standard.set(nextImageToShowIndex, forKey: "nextImageToShowIndex")
                        tabBarHeight+=80
                        print(tabBarHeight-UIScreen.main.bounds.height * 0.2)
                        getLocation()
                            } else {
                                print("Error: index out of bounds")
                            }
                                }, label: {
                                    Text("Set Location")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.black)
                                })
                                .padding()
                                .background(Color(#colorLiteral(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)))
                                .cornerRadius(15)
                                .offset(y: 280)
            }
            .animation(.easeInOut(duration: 0.2))
            .offset(y: tabBarOffset - UIScreen.main.bounds.height * 0.53 - 0.5*(tabBarHeight-UIScreen.main.bounds.height * 0.2)) // To adjust the view offset
            .onAppear {
                updateLocation()
            }
            
            VStack {
                VStack {
                    Rectangle()
                        .frame(width: 60, height: 5)
                        .cornerRadius(2.5)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                    Text("Saved Locations")
                        .font(.title)
                        .padding()
                    if showPtImages[0] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 0)
                    }
                    if showPtImages[1] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 1)
                    }
                    if showPtImages[2] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 2)
                    }
                    if showPtImages[3] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 3)
                    }
                    if showPtImages[4] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 4)
                    }
                    if showPtImages[5] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 5)
                    }
                    if showPtImages[6] {
                        PTImageInput(inputText: $inputText0, showPtImages: $showPtImages, nextImageToShowIndex: $nextImageToShowIndex, tabBarHeight: $tabBarHeight, index: 6)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: tabBarHeight, alignment: .center)
                .background(Color.white)
                .cornerRadius(15)
                .offset(y: tabBarOffset)
                .gesture(DragGesture().onChanged { value in
                    tabBarOffset = max(value.startLocation.y + value.translation.height, UIScreen.main.bounds.height * 0.45 - tabBarHeight)
                }.onEnded { value in
                    tabBarOffset = value.predictedEndLocation.y > UIScreen.main.bounds.height * 0.7 ? UIScreen.main.bounds.height * 0.53 : UIScreen.main.bounds.height * 0.45 - tabBarHeight
                })
            }
            .onAppear {
                tabBarHeight = UIScreen.main.bounds.height * 0.2
            }
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

