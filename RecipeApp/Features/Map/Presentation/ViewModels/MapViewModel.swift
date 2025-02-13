//
//  MapViewModel.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Combine
import SwiftUI
import MapKit

final class MapViewModel: ObservableObject {
    let dish: Dish
    @Published var position: MapCameraPosition
    @Published var selectedLocation: Dish? = nil
    private let coordinator: AppCoordinator
    
    init(dish: Dish, coordinator: AppCoordinator) {
        self.dish = dish
        self.coordinator = coordinator        
        self.position = .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: dish.location.lat,
                longitude: dish.location.lng
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        ))
    }
}
