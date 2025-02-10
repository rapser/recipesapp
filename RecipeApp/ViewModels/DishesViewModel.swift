//
//  DishesViewModel.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Combine

class DishesViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let getDishesUseCase: GetDishesUseCase
    
    init(getDishesUseCase: GetDishesUseCase) {
        self.getDishesUseCase = getDishesUseCase
        fetchDishes()
    }
    
    func fetchDishes() {
        print("Iniciando la carga de platos...")
        getDishesUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error al cargar platos: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { response in
                print("Platos cargados correctamente: \(response.dishes.count)")
                self.dishes = response.dishes
            })
            .store(in: &cancellables)
    }
    
    var filteredDishes: [Dish] {
        if searchText.isEmpty {
            return dishes
        } else {
            return dishes.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.ingredients.contains(where: { $0.lowercased().contains(searchText.lowercased()) }) }
        }
    }
}

