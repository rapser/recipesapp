//
//  AppDependencies.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

final class AppDependencies: ObservableObject {
    // MARK: - Repositories
    private let dishesRepository: DishesRepositoryProtocol
    
    // MARK: - Use Cases
    private let getDishesUseCase: GetDishesUseCaseProtocol
    
    // MARK: - ViewModels
    lazy var homeViewModel: HomeViewModel = {
        HomeViewModel(
            getDishesUseCase: getDishesUseCase,
            coordinator: coordinator
        )
    }()
    
    // MARK: - Coordinator
    let coordinator: AppCoordinator
    
    init() {
        // Configuración inicial
        let service = APIService()
        self.dishesRepository = DishesRepository(service: service)
        self.getDishesUseCase = GetDishesUseCase(repository: dishesRepository)
        self.coordinator = AppCoordinator()
        
        // Configurar dependencias circulares
        self.coordinator.dependencies = self
    }
    
    // MARK: - Factories
    func makeDetailViewModel(dish: Dish) -> DetailViewModel {
        DetailViewModel(dish: dish, coordinator: coordinator)
    }
    
    func makeMapViewModel(dish: Dish) -> MapViewModel {
        MapViewModel(dish: dish, coordinator: coordinator)
    }
}
