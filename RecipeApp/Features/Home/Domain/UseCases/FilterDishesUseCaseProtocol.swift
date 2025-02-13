//
//  FilterDishesUseCaseProtocol.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

protocol FilterDishesUseCaseProtocol {
    func execute(text: String, dishes: [Dish]) -> [Dish]
}
