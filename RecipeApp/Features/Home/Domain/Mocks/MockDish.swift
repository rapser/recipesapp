//
//  MockDish.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

extension Dish {
    static func mock(
        name: String = "Test Dish",
        photo: String = "",
        description: String = "Test Description",
        ingredients: [String] = ["Ingredient1"],
        origin: String = "Test Origin",
        location: DishLocation = DishLocation(lat: 0.0, lng: 0.0)
    ) -> Dish {
        Dish(
            name: name,
            photo: photo,
            description: description,
            ingredients: ingredients,
            origin: origin,
            location: location
        )
    }
}
