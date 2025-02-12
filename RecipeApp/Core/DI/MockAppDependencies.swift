//
//  MockAppDependencies.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import SwiftUI

class MockAppDependencies: AppDependenciesProtocol {
    // Implementaciones vacías o mock para métodos no usados en los tests
    func makeHomeViewModel() -> HomeViewModel {
        fatalError("No necesario para estos tests")
    }
    
    func makeDetailViewModel(dish: Dish) -> DetailViewModel {
        fatalError("No necesario para estos tests")
    }
    
    func makeMapViewModel(dish: Dish) -> MapViewModel {
        fatalError("No necesario para estos tests")
    }
}
