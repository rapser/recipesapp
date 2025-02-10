//
//  HomeView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = DishesViewModel(getDishesUseCase: GetDishesUseCase(repository: DishesRepository()))
    
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                
                DishesListView(
                    dishes: viewModel.filteredDishes,
                    onDishSelected: { dish in
                        coordinator.push(.dishDetail(dish))
                    }
                )
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    let mockRepository = MockDishesRepository()
    let useCase = GetDishesUseCase(repository: mockRepository)
    let viewModel = DishesViewModel(getDishesUseCase: useCase)
    viewModel.dishes = Dish.mockDishes
    
    return HomeView(viewModel: viewModel)
        .environmentObject(AppCoordinator())
}
