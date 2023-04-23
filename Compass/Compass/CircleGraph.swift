//
//  CircleGraphView.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

//
import Foundation
import SwiftUI
struct CircleGraphView: View {
    var angleFromNorth: Double 
    let coordinates: [(Double, Double)]

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
                                    .offset(y: -16)
                ZStack{
                    // Add concentric circles
                    ForEach(1..<7) { index in
                        if index == 6 {
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: width / 6 * CGFloat(index), height: height / 6 * CGFloat(index))
                                .position(x: centerX, y: centerY)
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
                }.rotationEffect(Angle(degrees: 360 - angleFromNorth))

            }
        }
    }
    
    func scaleCoordinates(coordinates: [(Double, Double)], width: Double, height: Double) -> [(Double, Double)] {
        let xMax = coordinates.map { $0.0 }.max()!
        let yMax = coordinates.map { $0.1 }.max()!
        let xMin = coordinates.map { $0.0 }.min()!
        let yMin = coordinates.map { $0.1 }.min()!
        let xRange = xMax - xMin
        let yRange = yMax - yMin
        let xScale = width * 0.25 / xRange
        let yScale = height * 0.25 / yRange
        return coordinates.map { ($0.0 * xScale, $0.1 * yScale) }
    }
    
    func shiftCoordinates(coordinates: [(Double, Double)], lastCoordinate: (Double, Double)) -> [(Double, Double)] {
        let xShift = lastCoordinate.0
        let yShift = lastCoordinate.1
        return coordinates.map { ($0.0 - xShift, $0.1 - yShift) }
    }
}
