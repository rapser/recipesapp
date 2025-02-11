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
        VStack {
            Map(position: $viewModel.position, interactionModes: .all) {
                Annotation(viewModel.dish.name, coordinate: viewModel.dish.location.coordinate) {
                    MapAnnotationView(dishName: viewModel.dish.name) {
                        viewModel.selectedLocation = viewModel.dish
                    }
                }
            }
            .navigationTitle("Origen de la Receta")
            .sheet(item: $viewModel.selectedLocation) { dish in
                LocationDetailView(dish: dish)
                    .presentationDetents([.medium])
            }
        }
        .navigationTitle(viewModel.dish.name)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

#Preview {
    MapView(viewModel: .preview())
        .environmentObject(AppCoordinator())
}

