//
//  MockDishesRepository.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI
import Combine

class MockDishesRepository: DishesRepositoryProtocol {
    private let result: Result<DishesResponse, Error>
    
    init(result: Result<DishesResponse, Error>) {
        self.result = result
    }
    
    func fetchDishes() -> AnyPublisher<DishesResponse, Error> {
        result.publisher
            .eraseToAnyPublisher()
    }
}
