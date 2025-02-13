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
    @Published private(set) var isLoading = false
    
    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Dependencies
    private let getDishesUseCase: GetDishesUseCaseProtocol
    private let filterDishesUseCase: FilterDishesUseCaseProtocol
    private let coordinator: AppCoordinator
    
    init(getDishesUseCase: GetDishesUseCaseProtocol,
         filterDishesUseCase: FilterDishesUseCaseProtocol,
         coordinator: AppCoordinator) {
        self.getDishesUseCase = getDishesUseCase
        self.filterDishesUseCase = filterDishesUseCase
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
            .map { [weak self] text, dishes in
                self?.filterDishesUseCase.execute(text: text, dishes: dishes) ?? []
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredDishes)
    }
    
    // MARK: - Data Handling
    func loadDishes() {
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
        case let urlError as URLError:
            errorMessage = "Error de conexión: \(urlError.localizedDescription)"
        default:
            errorMessage = error.localizedDescription
        }

        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = errorMessage
        }
    }
    
    // MARK: - Navigation
    func navigateToDetail(dish: Dish) {
        coordinator.push(.dishDetail(dish))
    }
}
