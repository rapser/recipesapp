//
//  DishesViewModel.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var filteredDishes: [Dish] = []
    @Published var isLoading: Bool = true
    
    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Dependencies
    private let getDishesUseCase: GetDishesUseCaseProtocol
    private let coordinator: AppCoordinator
    
    init(getDishesUseCase: GetDishesUseCaseProtocol, coordinator: AppCoordinator) {
        self.getDishesUseCase = getDishesUseCase
        self.coordinator = coordinator
        setupBindings()
        loadDishes()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        $searchText
            .combineLatest($dishes)
            .map { [weak self] text, dishes in
                guard let self = self else { return [] }
                return self.filterDishes(text: text, dishes: dishes)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredDishes)
    }
    
    // MARK: - Data Handling
    private func loadDishes() {
        isLoading = true
        getDishesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    self.handleError(error)
                }
            } receiveValue: { [weak self] dishes in
                guard let self = self else { return }
                self.dishes = dishes
                self.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    func retryLoading() {
        loadDishes()
    }
    
    private func handleError(_ error: Error) {
        let errorMessage: String

        if let apiError = error as? APIError {
            errorMessage = apiError.errorDescription ?? "Error desconocido en la API"
            print("API Error: \(apiError.localizedDescription)")
        } else {
            errorMessage = "Error inesperado: \(error.localizedDescription)"
        }

        DispatchQueue.main.async {
            self.errorMessage = errorMessage
        }
    }
    
    // MARK: - Search
    private func filterDishes(text: String, dishes: [Dish]) -> [Dish] {
        guard !text.isEmpty else { return dishes }
        
        let cleanedSearchText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .applyingTransform(.stripDiacritics, reverse: false)?
            .lowercased() ?? text.lowercased()

        return dishes.filter { dish in
            let normalizedDishName = dish.name
                .applyingTransform(.stripDiacritics, reverse: false)?
                .lowercased() ?? dish.name.lowercased()
            
            let matchesName = normalizedDishName.contains(cleanedSearchText)
            let matchesIngredient = dish.ingredients.contains { ingredient in
                ingredient
                    .applyingTransform(.stripDiacritics, reverse: false)?
                    .lowercased()
                    .contains(cleanedSearchText) ?? false
            }
            
            return matchesName || matchesIngredient
        }
    }
    
    // MARK: - Navigation
    func navigateToDetail(dish: Dish) {
        coordinator.push(.dishDetail(dish))
    }
}
