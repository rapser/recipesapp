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
        Map(position: $viewModel.position , interactionModes: .all) {
            Annotation(viewModel.dish.name,
                       coordinate: viewModel.dish.location.coordinate
                        ) {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .padding(10)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle()) // Fondo circular
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .onTapGesture {
                        viewModel.selectedLocation = viewModel.dish
                    }
            }
        }
        .navigationTitle("Recipe Origin")
        .sheet(item: $viewModel.selectedLocation) { dish in
            // Vista emergente cuando se selecciona el marcador
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.name)
                    .font(.title)
                    .padding(.bottom, 5)
                
                Text("Origen: \(dish.origin)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("Ingredients:")
                    .font(.headline)
                                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(dish.ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(.body)
                        }
                    }
                }
                .frame(maxHeight: 200) // Altura máxima para el ScrollView
            }
            .padding()
            .presentationDetents([.medium]) // Tamaño del modal
        }
    }
}

#Preview {
    MapView(viewModel: .preview())
        .environmentObject(AppCoordinator())
}

