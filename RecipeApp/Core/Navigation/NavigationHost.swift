//
//  NavigationHost.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct NavigationHost: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var dependencies: AppDependencies
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            NavigationFactory.view(for: .home, dependencies: dependencies)
                .navigationDestination(for: AppRoute.self) { route in
                    NavigationFactory.view(for: route, dependencies: dependencies)
                }
        }
    }
}
