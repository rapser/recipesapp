//
//  NavigationFactory.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct NavigationFactory {
    static func view(for route: AppRoute, dependencies: AppDependencies) -> some View {
        Group {
            switch route {
            case .home:
                HomeView(viewModel: dependencies.homeViewModel)
            case .dishDetail(let dish):
                DetailView(viewModel: dependencies.makeDetailViewModel(dish: dish))
            case .map(let dish):
                MapView(viewModel: dependencies.makeMapViewModel(dish: dish))
            }
        }
    }
}

