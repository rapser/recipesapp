//
//  AppCoordinator.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

final class AppCoordinator: Coordinator {
    @Published var navigationPath: [AppRoute] = []
    
    // Inyección de dependencias comunes
    let dishesRepository = DishesRepository()
}

