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
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($dishes)
            .map { text, dishes in
                self.filterDishes(text: text, dishes: dishes)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredDishes)
    }
    
    // MARK: - Data Handling
    private func loadDishes() {
        isLoading = true
        
        getDishesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] dishes in
                self?.dishes = dishes
                self?.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    func retryLoading() {
        loadDishes()
    }
    
    private func handleError(_ error: Error) {
        let errorMessage: String

        switch error {
        case let apiError as APIError:
            errorMessage = apiError.errorDescription ?? "Error desconocido en la API"
            debugPrint("API Error: \(apiError.localizedDescription)")
        default:
            errorMessage = "Error inesperado: \(error.localizedDescription)"
        }

        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = errorMessage
        }
    }
    
    // MARK: - Search
    private func filterDishes(text: String, dishes: [Dish]) -> [Dish] {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return dishes }

        let cleanedSearchText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .applyingTransform(.stripDiacritics, reverse: false)?
            .lowercased() ?? text.lowercased()

        return dishes.lazy.filter { dish in
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
    
    // MARK: - Navigation
    func navigateToDetail(dish: Dish) {
        coordinator.push(.dishDetail(dish))
    }
}
