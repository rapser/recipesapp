//
//  DetailView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack(spacing: 16) {
            // 📸 Imagen del plato
            DishImageView(photoURL: viewModel.dish.photo)

            // 📝 Descripción del plato
            DishDescriptionView(description: viewModel.dish.description)

            // 🛒 Lista de ingredientes
            IngredientsListView(ingredients: viewModel.dish.ingredients)

            Spacer() // Asegura que el botón quede siempre abajo

            // 📍 Botón "Ver en Mapa"
            MapViewButton {
                viewModel.navigateToMap()
            }
        }
        .navigationTitle(viewModel.dish.name)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    DetailView(viewModel: .preview())
        .environmentObject(AppCoordinator())
}

