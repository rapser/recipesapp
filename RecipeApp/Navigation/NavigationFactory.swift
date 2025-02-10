//
//  NavigationFactory.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct NavigationFactory {
    static func view(for route: AppRoute, coordinator: AppCoordinator) -> AnyView {
        switch route {
        case .dishDetail(let dish):
            return AnyView(DetailView(dish: dish)
                .environmentObject(coordinator))
        case .map(let dish):
            return AnyView(MapView(dish: dish)
                .environmentObject(coordinator))
        default:
            return AnyView(EmptyView())
        }
    }
}

