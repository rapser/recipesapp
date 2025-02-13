//
//  AppCoordinator.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

final class AppCoordinator: ObservableObject, Coordinator {
    @Published var navigationPath: [AppRoute] = []
    private weak var dependencies: AppDependenciesProtocol?
    
    init(dependencies: AppDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func push(_ route: AppRoute) {
        navigationPath.append(route)
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func popToRoot() {
        navigationPath.removeAll()
    }
}
