//
//  PreviewDependencies.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import SwiftUI

final class PreviewDependencies: AppDependenciesProtocol {
    func makeHomeViewModel() -> HomeViewModel {
        let mockDishes = Dish.mockDishes
        let mockUseCase = MockGetDishesUseCase(result: .success(mockDishes))
        let mockFilterUseCase = MockFilterDishesUseCase()
        let coordinator = AppCoordinator(dependencies: self)
        return HomeViewModel(getDishesUseCase: mockUseCase,
                             filterDishesUseCase: mockFilterUseCase,
                             coordinator: coordinator)
    }
    
    func makeDetailViewModel(dish: Dish) -> DetailViewModel {
        DetailViewModel(dish: dish, coordinator: AppCoordinator(dependencies: self))
    }
    
    func makeMapViewModel(dish: Dish) -> MapViewModel {
        MapViewModel(dish: dish, coordinator: AppCoordinator(dependencies: self))
    }
}
