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
    
    // Acepta un Result<DishesResponse, Error>
    init(result: Result<DishesResponse, Error>) {
        self.result = result
    }
    
    func fetchDishes() -> AnyPublisher<DishesResponse, Error> {
        result.publisher
            .eraseToAnyPublisher()
    }
}

// MARK: - Datos de prueba
extension Dish {
    static let mockDishes: [Dish] = [
        Dish(
            id: UUID(),
            name: "Fettuccine Alfredo",
            photo: "https://images.aws.nestle.recipes/resized/cc72869fabfc2bdfa036fd1fe0e2bad8_creamy_alfredo_pasta_long_left_1080_850.jpg",
            description: "Pasta italiana con salsa cremosa de queso y mantequilla",
            ingredients: ["Fettuccine", "Mantequilla", "Queso Parmesano", "Crema"],
            origin: "Italia",
            location: DishLocation(lat: 41.9028, lng: 12.4964)
        ),
        Dish(
            id: UUID(),
            name: "Sopa Shambar",
            photo: "https://blog.amigofoods.com/wp-content/uploads/2023/04/shambar-peruvian-soup.jpg",
            description: "Tradicional sopa trujillana con menestras y carnes",
            ingredients: ["Trigo", "Frijoles", "Carne de cerdo", "Culantro"],
            origin: "Perú",
            location: DishLocation(lat: -8.11599, lng: -79.02998) // Trujillo, Perú
        )
    ]
}
