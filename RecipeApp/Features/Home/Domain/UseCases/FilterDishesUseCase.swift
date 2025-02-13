//
//  FilterDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

final class FilterDishesUseCase: FilterDishesUseCaseProtocol {
    func execute(text: String, dishes: [Dish]) -> [Dish] {
        let cleanedSearchText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .applyingTransform(.stripDiacritics, reverse: false)?
            .lowercased() ?? text.lowercased()
        
        guard !cleanedSearchText.isEmpty else { return dishes }

        return dishes.filter { dish in
            let normalizedDishName = dish.name
                .applyingTransform(.stripDiacritics, reverse: false)?
                .lowercased() ?? dish.name.lowercased()

            if normalizedDishName.contains(cleanedSearchText) {
                return true
            }

            return dish.ingredients.contains { ingredient in
                let normalizedIngredient = ingredient
                    .applyingTransform(.stripDiacritics, reverse: false)?
                    .lowercased() ?? ingredient.lowercased()
                
                return normalizedIngredient.contains(cleanedSearchText)
            }
        }
    }
}
