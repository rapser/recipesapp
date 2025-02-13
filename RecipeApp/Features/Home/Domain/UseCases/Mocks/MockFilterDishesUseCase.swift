//
//  MockFilterDishesUseCase.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

class MockFilterDishesUseCase: FilterDishesUseCaseProtocol {
    func execute(text: String, dishes: [Dish]) -> [Dish] {
        guard !text.isEmpty else { return dishes }
        return dishes.filter { $0.name.lowercased().contains(text.lowercased()) }
    }
}
