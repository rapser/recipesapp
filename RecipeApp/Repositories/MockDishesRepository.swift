//
//  MockDishesRepository.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI
import Combine

class MockDishesRepository: DishesRepositoryProtocol {
    
    // Configuración de mock
    var mockResponse: DishesResponse?
    var mockError: Error?
    var fetchCallCount = 0
    
    func fetchDishes() -> AnyPublisher<DishesResponse, Error> {
        fetchCallCount += 1
        
        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return Just(mockResponse ?? .mockDishes)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Datos de prueba
extension DishesResponse {
    static let mockDishes = DishesResponse(
        dishes: [
            Dish(
                name: "Mock Pasta",
                photo: "https://example.com/mock-pasta.jpg",
                description: "Mock pasta description",
                ingredients: ["Pasta", "Tomato"],
                origin: "Mock Italy",
                location: Location(lat: 41.8919, lng: 12.5113)
            ),
            Dish(
                name: "Mock Sushi",
                photo: "https://example.com/mock-sushi.jpg",
                description: "Mock sushi description",
                ingredients: ["Rice", "Fish"],
                origin: "Mock Japan",
                location: Location(lat: 35.6895, lng: 139.6917)
            )
        ]
    )
}
