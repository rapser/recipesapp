//
//  DetailViewModel+Preview.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Foundation

extension DetailViewModel {
    static func preview() -> DetailViewModel {
        let mockCoordinator = AppCoordinator()
        
        let mockDish = Dish(
            name: "Sopa a la minuta",
            photo: "https://www.recetasnestle.com.pe/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/78e3eee085a9685a8ddf003539dade14.webp?itok=NN5Zl_8v",
            description: "Aderezar la cebolla en aceite, colocar a hervir todo.",
            ingredients: ["Carne", "Papa", "Fideos", "Huevo"],
            origin: "Perú",
            location: DishLocation(lat: -12.0464, lng: -77.0428)
        )

        return DetailViewModel(dish: mockDish, coordinator: mockCoordinator)
    }
}
