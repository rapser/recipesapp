//
//  AppDependencies.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

protocol AppDependenciesProtocol: AnyObject {
    func makeHomeViewModel() -> HomeViewModel
    func makeDetailViewModel(dish: Dish) -> DetailViewModel
    func makeMapViewModel(dish: Dish) -> MapViewModel
}

final class AppDependencies: AppDependenciesProtocol, ObservableObject {
    // MARK: - Dependencies
    private let service: APIService
    private let dishesRepository: DishesRepositoryProtocol
    private let getDishesUseCase: GetDishesUseCaseProtocol
    private let filterDishesUseCase: FilterDishesUseCase

    // MARK: - Coordinator
    var coordinator: AppCoordinator!
    
    init(service: APIService = APIService()) {
        self.service = service
        self.dishesRepository = DishesRepository(service: service)
        self.getDishesUseCase = GetDishesUseCase(repository: dishesRepository)
        self.filterDishesUseCase = FilterDishesUseCase()
        self.coordinator = AppCoordinator(dependencies: self)
    }
    
    // MARK: - ViewModel Factories
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            getDishesUseCase: getDishesUseCase,
            filterDishesUseCase: filterDishesUseCase,
            coordinator: coordinator
        )
    }
    
    func makeDetailViewModel(dish: Dish) -> DetailViewModel {
        DetailViewModel(
            dish: dish,
            coordinator: coordinator
        )
    }
    
    func makeMapViewModel(dish: Dish) -> MapViewModel {
        MapViewModel(
            dish: dish,
            coordinator: coordinator
        )
    }
}
