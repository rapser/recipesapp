//
//  GetDishesUseCaseProtocol.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import Combine

protocol GetDishesUseCaseProtocol {
    func execute() -> AnyPublisher<[Dish], Error>
}
