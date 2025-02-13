//
//  DetailViewModel+Preview.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Foundation

extension DetailViewModel {
    static func preview() -> DetailViewModel {
        let dependencies = PreviewDependencies()
        guard let dish = Dish.mockDishes.first else {
            fatalError("No hay platos en mockDishes para el preview")
        }
        return dependencies.makeDetailViewModel(dish: dish)
    }
}
