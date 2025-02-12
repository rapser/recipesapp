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
            
            DishImageView(photoURL: viewModel.dish.photo)
            DishDescriptionView(description: viewModel.dish.description)
            IngredientsListView(ingredients: viewModel.dish.ingredients)
            Spacer()
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
}

