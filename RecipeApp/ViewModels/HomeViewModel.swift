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
        
        let lowercasedText = text.lowercased()
        return dishes.filter {
            $0.name.lowercased().contains(lowercasedText) ||
            $0.ingredients.contains { $0.lowercased().contains(lowercasedText) }
        }
    }
    
    private func loadDishes() {
        getDishesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] dishes in
                self?.dishes = dishes
            }
            .store(in: &cancellables)
    }
    
    func navigateToDetail(dish: Dish) {
        coordinator.push(.dishDetail(dish))
    }
}

