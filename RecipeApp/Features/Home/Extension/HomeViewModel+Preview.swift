//
//  HomeViewModel+Preview.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Foundation

extension HomeViewModel {
    static func preview() -> HomeViewModel {
        let mockRepository = MockDishesRepository()
        let mockUseCase = GetDishesUseCase(repository: mockRepository)
        let mockCoordinator = AppCoordinator()

        let viewModel = HomeViewModel(
            getDishesUseCase: mockUseCase,
            coordinator: mockCoordinator
        )

        // Configurar datos mock
        let mockDishes = Dish.mockDishes
        mockRepository.mockDishesResponse = DishesResponse(dishes: mockDishes)

        // ⚡️ Forzar actualización manual de `dishes`
        viewModel.dishes = mockDishes
        viewModel.errorMessage = nil

        return viewModel
    }
}
