//
//  CompassApp.swift
//  Compass
//
//  Created by Rohan Taneja on 4/22/23.
//

import SwiftUI

@main
struct CompassApp: App {
    let coordinates: [(Double, Double)] = [(0, 0), (1, 1), (2, 0), (1, -1)]
    
    var body: some Scene {
        WindowGroup {
//           HomeView()
            CircleGraph(coordinates: coordinates)
                .padding()
        }
    }
}
