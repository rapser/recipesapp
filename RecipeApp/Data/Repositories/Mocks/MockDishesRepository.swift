//
//  MockDishesRepository.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI
import Combine

final class MockDishesRepository: DishesRepositoryProtocol {
    var mockDishesResponse: DishesResponse? = DishesResponse(dishes: Dish.mockDishes)
    var error: Error?

    func fetchDishes() -> AnyPublisher<DishesResponse, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let response = mockDishesResponse else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Datos de prueba
extension Dish {
    static let mockDishes: [Dish] = [
        Dish(
            id: UUID(),
            name: "Pizza Margherita",
            photo: "https://ejemplo.com/pizza.jpg",
            description: "Clásica pizza italiana",
            ingredients: ["Harina", "Tomate", "Mozzarella"],
            origin: "Italia",
            location: DishLocation(lat: 41.9028, lng: 12.4964)
        ),
        Dish(
            id: UUID(),
            name: "Sushi Roll",
            photo: "https://ejemplo.com/sushi.jpg",
            description: "Sushi tradicional japonés",
            ingredients: ["Arroz", "Salmón", "Alga Nori"],
            origin: "Japón",
            location: DishLocation(lat: 35.6895, lng: 139.6917)
        )
    ]
}
