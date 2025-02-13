//
//  HomeViewModel+Preview.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Foundation

extension HomeViewModel {
    static func preview() -> HomeViewModel {
        let dependencies = PreviewDependencies()
        return dependencies.makeHomeViewModel()
    }
}
