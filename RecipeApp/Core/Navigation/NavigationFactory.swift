//
//  NavigationFactory.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct NavigationFactory {
    static func view(for route: AppRoute, dependencies: AppDependenciesProtocol) -> some View {
        Group {
            switch route {
            case .home:
                HomeView(viewModel: dependencies.makeHomeViewModel())
            case .dishDetail(let dish):
                DetailView(viewModel: dependencies.makeDetailViewModel(dish: dish))
            case .map(let dish):
                MapView(viewModel: dependencies.makeMapViewModel(dish: dish))
            }
        }
    }
}

