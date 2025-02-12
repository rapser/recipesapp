//
//  GetDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Combine

final class GetDishesUseCase: GetDishesUseCaseProtocol {
    private let repository: DishesRepositoryProtocol
    
    init(repository: DishesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Dish], Error> {
        return repository.fetchDishes()
            .map { $0.dishes } // Convertimos DishesResponse a [Dish]
            .catch { error -> AnyPublisher<[Dish], Error> in
                print("Error fetching dishes: \(error.localizedDescription)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
