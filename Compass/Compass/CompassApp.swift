//
//  CompassApp.swift
//  Compass
//
//  Created by Rohan Taneja on 4/22/23.
//

import SwiftUI

@main
struct CompassApp: App {
    let coordinates: [(Double, Double)] = [(3.0001, 12.0005), (3.0002, 12.0004), (3.0005, 12.0008), (3.0008, 12.0009)]
    
    var body: some Scene {
        WindowGroup {
            CircleGraphView(angleFromNorth: 0.0, coordinates: coordinates )
                .padding()
        }
    }
}
