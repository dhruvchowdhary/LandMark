//
//  AngleCalculator.swift
//  Compass
//
//  Created by Dhruv Chowdhary on 4/22/23.
//

import Foundation
import CoreLocation

class AngleCalculator {

    /// Computes the angle between your current location and a target location
    ///
    /// - Parameters:
    ///   - currentLocation: The current location of the user, obtained from Core Location
    ///   - targetLocation: The target location to compute the angle to
    ///   - currentHeading: The current heading of the user, relative to true north, obtained from Core Location
    /// - Returns: The angle between the user's current location and the target location, expressed in degrees between 0 and 360.
    func computeAngle(
        from currentLocation: CLLocationCoordinate2D,
        to targetLocation: CLLocationCoordinate2D,
        with currentHeading: CLLocationDirection
    ) -> CLLocationDirection {

        // Compute the bearing between the current location and the target location
        let bearing = getBearing(point1: currentLocation, point2: targetLocation)

        // Compute the angle between the two points relative to the current heading
        var angle = bearing - currentHeading
        if angle < 0 {
            angle += 360
        }

        return angle
    }

    /// Computes the bearing (direction) between two geographic coordinates using the Haversine formula.
    ///
    /// - Parameters:
    ///   - point1: The first point, expressed as a `CLLocationCoordinate2D` struct.
    ///   - point2: The second point, expressed as a `CLLocationCoordinate2D` struct.
    /// - Returns: The bearing (direction) between the two points, expressed in degrees between 0 and 360.
    private func getBearing(point1: CLLocationCoordinate2D, point2: CLLocationCoordinate2D) -> CLLocationDirection {

        // Convert the latitude and longitude values to radians
        let lat1 = point1.latitude.degreesToRadians
        let lon1 = point1.longitude.degreesToRadians
        let lat2 = point2.latitude.degreesToRadians
        let lon2 = point2.longitude.degreesToRadians

        // Compute the difference in longitude between the two points
        let dLon = lon2 - lon1

        // Compute the direction (bearing) between the two points using the Haversine formula
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        var radiansBearing = atan2(y, x)
        if radiansBearing < 0 {
            radiansBearing += 2 * Double.pi
        }
        let degreesBearing = radiansBearing.radiansToDegrees

        return degreesBearing
    }
}

// Extension to convert degrees to radians
private extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
}
