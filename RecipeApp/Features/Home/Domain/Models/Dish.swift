//
//  Dish.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Foundation

struct Dish: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let photo: String
    let description: String
    let ingredients: [String]
    let origin: String
    let location: DishLocation
    
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
