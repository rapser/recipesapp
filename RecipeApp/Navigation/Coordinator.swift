//
//  Coordinator.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype Route: Hashable
    var navigationPath: [Route] { get set }
    func push(_ route: Route)
    func pop()
    func popToRoot()
}
