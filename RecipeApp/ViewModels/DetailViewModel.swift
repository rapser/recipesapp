//
//  DetailViewModel.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Combine

final class DetailViewModel: ObservableObject {
    let dish: Dish
    private let coordinator: AppCoordinator
    
    init(dish: Dish, coordinator: AppCoordinator) {
        self.dish = dish
        self.coordinator = coordinator
    }
    
    func navigateToMap() {
        coordinator.push(.map(dish))
    }
}
