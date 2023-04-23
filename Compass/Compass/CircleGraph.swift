//
//  CircleGraphView.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

//
import CoreLocation
import Foundation
import SwiftUI
struct CircleGraphView: View {
    let coordinates = MyVariables.recentLocations
    @State private var currentView: String = "circleGraph"
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var angleFromNorth: Double = 0.0

    var body: some View {
        GeometryReader { geometry in
            let padding: CGFloat = 20
            let width = min(geometry.size.width, geometry.size.height) - padding * 2
            let height = width
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            let scaledCoordinates = scaleCoordinates(coordinates: coordinates, width: Double(width), height: Double(height))
            let shiftedCoordinates = shiftCoordinates(coordinates: scaledCoordinates, lastCoordinate: scaledCoordinates.last!)
            
            ZStack {
                Image("mountain-background1")
                                    .resizable()
                                    .scaledToFill()
                                    .edgesIgnoringSafeArea(.all)
                               
                HStack {
                        Button(action: {
                            viewRouter.currentScreen = .homeScreen
                        }, label: {
                            Text("Compass")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                                .padding()
                        })
                        Button(action: {
                            viewRouter.currentScreen = .circleScreen
                        }, label: {
                            Text("Retrace")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                                .underline()
                                .padding()
                        })
                    }
                        .offset(y: -280)
                ZStack{
                    // Add concentric circles
                    ForEach(1..<7) { index in
                        if index == 6 {
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: width / 6 * CGFloat(index), height: height / 6 * CGFloat(index))
                                .position(x: centerX, y: centerY)
                            // Add image on top of largest concentric circle
                            Image("Arrow-1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .position(x: centerX, y: -5 + centerY - height / 6 * CGFloat(index) / 2 - 15)
                                .rotationEffect(Angle(degrees: 360 - angleFromNorth))
                                                    
                        } else {
                            Circle()
                                .stroke(Color(red: 105.0, green: 105.0, blue: 105.0), lineWidth: 1)
                                .frame(width: width / 6 * CGFloat(index), height: height / 6 * CGFloat(index))
                                .position(x: centerX, y: centerY)
                        }
                    }
                    
                    Path { path in
                        for (index, coordinate) in shiftedCoordinates.enumerated() {
                            let x = CGFloat(coordinate.0) + centerX
                            let y = -CGFloat(coordinate.1) + centerY
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                    
                    ForEach(0..<shiftedCoordinates.count) { index in
                        let coordinate = shiftedCoordinates[index]
                        let x = CGFloat(coordinate.0) + centerX
                        let y = -CGFloat(coordinate.1) + centerY
                        if index == shiftedCoordinates.count - 1 {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 10, height: 10)
                                .position(x: x, y: y)
                        } else {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .position(x: x, y: y)
                        }
                    }
                }

            }.onAppear{
                updateLocation()
            }
            
        }
    }
    
    func scaleCoordinates(coordinates: [(Double, Double)], width: Double, height: Double) -> [(Double, Double)] {
        //print(coordinates)
        let xMax = coordinates.map { $0.0 }.max()!
        let yMax = coordinates.map { $0.1 }.max()!
        let xMin = coordinates.map { $0.0 }.min()!
        let yMin = coordinates.map { $0.1 }.min()!
        //print(xMax, yMax, xMin, yMin)
        var xRange = xMax - xMin
        var yRange = yMax - yMin
        if xRange == 0{
            xRange = 1
        }
        if yRange == 0 {
            yRange = 1
        }
                
        let xScale = width * 0.25 / xRange
        let yScale = height * 0.25 / yRange
        //print(xScale, yScale)
        //print(coordinates.map { ($0.0 * xScale, $0.1 * yScale) })
        return coordinates.map { ($0.0 * xScale, $0.1 * yScale) }
    }
    
    func shiftCoordinates(coordinates: [(Double, Double)], lastCoordinate: (Double, Double)) -> [(Double, Double)] {
        let xShift = lastCoordinate.0
        let yShift = lastCoordinate.1
        //print(coordinates.map { ($0.0 - xShift, $0.1 - yShift) })
        return coordinates.map { ($0.0 - xShift, $0.1 - yShift) }
    }
    
    func updateLocation() {
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
    //            if CLLocationManager.locationServicesEnabled() {
                    let currLocation = locationManager.location?.coordinate
         //           currLatitude = currLocation?.latitude ?? 0.0
          //          currLongitude = currLocation?.longitude ?? 0.0
                    
               // angleFromNorth = self.compassHeading.degrees * -1
                if let heading = locationManager.heading?.trueHeading {
                    angleFromNorth = heading
                }
            }
            timer.fire()
        }
    
}

