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

// 2. AppDependencies corregido
final class AppDependencies: AppDependenciesProtocol, ObservableObject {
    // MARK: - Dependencies
    private let service: APIService
    private let dishesRepository: DishesRepositoryProtocol
    private let getDishesUseCase: GetDishesUseCaseProtocol
    
    // MARK: - Coordinator
    var coordinator: AppCoordinator!
    
    init(service: APIService = APIService()) {
        self.service = service
        self.dishesRepository = DishesRepository(service: service)
        self.getDishesUseCase = GetDishesUseCase(repository: dishesRepository)
        
        // 2. Inicializa coordinator DESPUÉS de las demás propiedades
        self.coordinator = AppCoordinator(dependencies: self)
    }
    
    // MARK: - ViewModel Factories
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            getDishesUseCase: getDishesUseCase,
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
