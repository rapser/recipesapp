//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by miguel tomairo on 7/02/25.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    @State private var showSplash = true
    @StateObject private var coordinator = AppCoordinator()
    
    // Configuración única de dependencias
    private let homeView: HomeView = {
        let repository = DishesRepository()
        let useCase = GetDishesUseCase(repository: repository)
        let viewModel = DishesViewModel(getDishesUseCase: useCase)
        return HomeView(viewModel: viewModel)
    }()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationHost(
                    path: $coordinator.navigationPath,
                    root: homeView
                        .environmentObject(coordinator),
                    destinations: { route in
                        NavigationFactory.view(for: route, coordinator: coordinator)
                    }
                )
                .opacity(showSplash ? 0 : 1)
                
                if showSplash {
                    SplashView(showSplash: $showSplash)
                        .transition(.opacity)
                }
            }
        }
    }
}
