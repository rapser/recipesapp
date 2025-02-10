//
//  GetDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Combine

class GetDishesUseCase {
    private let repository: DishesRepositoryProtocol
    
    init(repository: DishesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<DishesResponse, Error> {
        return repository.fetchDishes()
    }
}
