//
//  MockAppDependencies.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import SwiftUI

class MockAppDependencies: AppDependenciesProtocol {
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
