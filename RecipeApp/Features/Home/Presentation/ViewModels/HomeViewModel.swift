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
    
    // MARK: - Methods
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
    
    private func filterDishes(text: String, dishes: [Dish]) -> [Dish] {
        guard !text.isEmpty else { return dishes }
        
        let cleanedSearchText = text
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: .alphanumerics.inverted)
            .joined()
        
        let normalizedSearchText = cleanedSearchText
            .applyingTransform(.stripDiacritics, reverse: false)?
            .lowercased() ?? cleanedSearchText.lowercased()
        
        return dishes.filter { dish in
            let normalizedDishName = dish.name
                .applyingTransform(.stripDiacritics, reverse: false)?
                .lowercased() ?? dish.name.lowercased()
            
            return normalizedDishName.contains(normalizedSearchText) ||
            dish.ingredients.contains { ingredient in
                let normalizedIngredient = ingredient
                    .applyingTransform(.stripDiacritics, reverse: false)?
                    .lowercased() ?? ingredient.lowercased()
                return normalizedIngredient.contains(normalizedSearchText)
            }
        }
    }
    
    private func loadDishes() {
        isLoading = true // <- Activar Skeleton
        getDishesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false // <- Desactivar Skeleton en caso de error
            } receiveValue: { [weak self] dishes in
                self?.dishes = dishes
                self?.isLoading = false // <- Desactivar Skeleton cuando se cargan los datos
            }
            .store(in: &cancellables)
    }
    
    func navigateToDetail(dish: Dish) {
        coordinator.push(.dishDetail(dish))
    }
}

