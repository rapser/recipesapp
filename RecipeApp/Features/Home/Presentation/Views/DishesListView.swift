//
//  DishesListView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct DishesListView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                if viewModel.isLoading {
                    // Mostrar Skeleton mientras se cargan los datos
                    ForEach(0..<6, id: \.self) { _ in
                        DishSkeletonView()
                    }
                } else {
                    ForEach(viewModel.filteredDishes, id: \.id) { dish in
                        DishCard(dish: dish, onDishSelected: viewModel.navigateToDetail)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

