//
//  CircleGraph.swift
//  Compass
//
//  Created by Shivan Patel on 4/22/23.
//

//
import Foundation
import SwiftUI

struct CircleGraph: View {
    let coordinates: [(Double, Double)]

    var body: some View {
        GeometryReader { geometry in
            let padding: CGFloat = 20
            let width = min(geometry.size.width, geometry.size.height) - padding * 2
            let height = width
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            let lastCoordinate = coordinates.last ?? (0, 0)
            let xFactor = CGFloat(lastCoordinate.0) / 10
            let yFactor = CGFloat(lastCoordinate.1) / 10
            let xOffset = centerX - width / 2 * xFactor
            let yOffset = centerY - height / 2 * yFactor
            
            ZStack {
                VStack {
                    ForEach(0..<11) { row in
                        HStack {
                            ForEach(0..<11) { column in
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: width / 11, height: height / 11)
                            }
                        }
                    }
                }
                .offset(x: centerX - width / 2, y: centerY - height / 2)
                
                Path { path in
                    for (index, coordinate) in coordinates.enumerated() {
                        let x = CGFloat(coordinate.0) * width / 10 + xOffset
                        let y = -CGFloat(coordinate.1) * height / 10 + yOffset
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
                
                ForEach(0..<coordinates.count) { index in
                    let coordinate = coordinates[index]
                    let x = CGFloat(coordinate.0) * width / 10 + xOffset
                    let y = -CGFloat(coordinate.1) * height / 10 + yOffset
                    if index == coordinates.count - 1 {
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
        }
    }
}
