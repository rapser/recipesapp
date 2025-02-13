//
//  MockGetDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import Combine

class MockGetDishesUseCase: GetDishesUseCaseProtocol {
    let result: Result<[Dish], Error>
    
    init(result: Result<[Dish], Error>) {
        self.result = result
    }
    
    func execute() -> AnyPublisher<[Dish], Error> {
        result.publisher.eraseToAnyPublisher()
    }
}
