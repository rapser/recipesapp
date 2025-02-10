//
//  Untitled.swift
//  RecipeApp
//
//  Created by miguel tomairo on 7/02/25.
//

import Foundation

struct DishesResponse: Codable {
    let dishes: [Dish]
}

struct Dish: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let photo: String
    let description: String
    let ingredients: [String]
    let origin: String
    let location: Location
    
    // Hashable permite comparar estructuras fácilmente
    static func == (lhs: Dish, rhs: Dish) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, photo, description, ingredients, origin, location
    }
}

extension Dish {
    static let mockDishes: [Dish] = [
        Dish(
            name: "Test Dish",
            photo: "https://example.com/test.jpg",
            description: "Test description",
            ingredients: ["Ing1", "Ing2"],
            origin: "Testland",
            location: Location(lat: 0, lng: 0)
        ),
        Dish(
            name: "Test Dish",
            photo: "https://example.com/test.jpg",
            description: "Test description",
            ingredients: ["Ing1", "Ing2"],
            origin: "Testland",
            location: Location(lat: 0, lng: 0)
        )
    ]
}
