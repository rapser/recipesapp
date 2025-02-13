//
//  MockFilterDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

class MockFilterDishesUseCase: FilterDishesUseCaseProtocol {
    func execute(text: String, dishes: [Dish]) -> [Dish] {
        guard !text.isEmpty else { return dishes }

        let normalizedQuery = text.folding(options: .diacriticInsensitive, locale: .current).lowercased()

        return dishes.filter { dish in
            let normalizedDishName = dish.name.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            return normalizedDishName.contains(normalizedQuery)
        }
    }
}
