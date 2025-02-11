//
//  Location.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import Foundation
import CoreLocation

struct DishLocation: Hashable, Codable {
    let lat: Double
    let lng: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
