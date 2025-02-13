//
//  MapView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        let dish = viewModel.dish

        Map(position: $viewModel.position, interactionModes: .all) {
            Annotation(dish.name, coordinate: dish.location.coordinate) {
                MapAnnotationView(dishName: dish.name) {
                    viewModel.selectedLocation = dish
                }
                .accessibilityLabel("Ubicación de la receta: \(dish.name)")
                .accessibilityHint("Toca para ver más detalles sobre el origen de \(dish.name)")
            }
        }
        .navigationTitle("Origen de la Receta")
        .sheet(item: $viewModel.selectedLocation) { dish in
            LocationDetailView(dish: dish)
                .presentationDetents([.medium, .fraction(0.75)])
        }
    }
}

#Preview {
    MapView(viewModel: .preview())
}

