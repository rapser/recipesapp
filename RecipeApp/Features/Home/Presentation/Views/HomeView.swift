//
//  HomeView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                
                DishesListView(
                    dishes: viewModel.filteredDishes,
                    onDishSelected: { dish in
                        viewModel.navigateToDetail(dish: dish)
                    }
                )
            }
            .navigationTitle("Recipes")
            .errorAlert(errorMessage: $viewModel.errorMessage)
        }
    }
}

#Preview {
    HomeView(viewModel: .preview())
        .environmentObject(AppCoordinator())
}
