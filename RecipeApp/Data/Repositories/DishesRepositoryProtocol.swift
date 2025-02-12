//
//  DishesRepositoryProtocol.swift
//  RecipeApp
//
//  Created by miguel tomairo on 12/02/25.
//

import Combine

protocol DishesRepositoryProtocol {
    func fetchDishes() -> AnyPublisher<DishesResponse, Error>
}
