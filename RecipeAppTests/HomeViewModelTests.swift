//
//  HomeViewModelTests.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import XCTest
import Combine

final class HomeViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - ✅ Caso de éxito: Carga de platos
    func testLoadDishesSuccess() {
        let mockDishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(mockDishes))
        
        
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
//        let coordinator = AppCoordinator()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: coordinator)
        
        let expectation = XCTestExpectation(description: "Dishes loaded")
        
        viewModel.$dishes
            .dropFirst()
            .sink { dishes in
                XCTAssertEqual(dishes, mockDishes)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - ❌ Caso de error: Fallo en la carga de platos
    func testLoadDishesFailure() {
        let mockError = NSError(domain: "Test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error en la carga"])
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
//        let coordinator = AppCoordinator()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: coordinator)
        
        let expectation = XCTestExpectation(description: "Error message set")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Error en la carga")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - 🔍 Filtrado por nombre
    func testSearchFilterByName() {
        let dishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(dishes))
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        let viewModel = HomeViewModel(
            getDishesUseCase: mockUseCase,
            coordinator: coordinator
        )
        
        // Espera a que los datos se carguen
        let loadExpectation = XCTestExpectation(description: "Wait for dishes to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)
        
        // Aplica el filtro
        viewModel.searchText = "Pas"
        
        // Espera a que el filtro se actualice
        let filterExpectation = XCTestExpectation(description: "Wait for filter")
        DispatchQueue.main.async {
            filterExpectation.fulfill()
        }
        wait(for: [filterExpectation], timeout: 1.0)
        
        // Verifica
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "Pasta")
    }
    
    // MARK: - 🧪 Filtrado ignorando mayúsculas y acentos
    func testSearchFilterIgnoresCaseAndDiacritics() {
        let dishes = [
            Dish.mock(name: "Café"),
            Dish.mock(name: "PIZZA"),
            Dish.mock(name: "té Verde")
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(dishes))
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        let viewModel = HomeViewModel(
            getDishesUseCase: mockUseCase,
            coordinator: coordinator
        )
        
        // Espera a que los datos se carguen
        let loadExpectation = XCTestExpectation(description: "Wait for dishes to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)
        
        // Caso 1: "cafe" vs "Café"
        viewModel.searchText = "cafe"
        waitForFilterUpdate()
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "Café")
        
        // Caso 2: "pizza" vs "PIZZA"
        viewModel.searchText = "pizza"
        waitForFilterUpdate()
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "PIZZA")
        
        // Caso 3: "Te" vs "té Verde"
        viewModel.searchText = "Te"
        waitForFilterUpdate()
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "té Verde")
    }

    // Función helper para esperar actualización del filtro
    private func waitForFilterUpdate() {
        let expectation = XCTestExpectation(description: "Wait for filter")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 🛠 Filtrado con caracteres extraños
    func testSearchWithSpecialCharacters() {
        let dishes = [
            Dish.mock(name: "Café"),
            Dish.mock(name: "Pizza"),
            Dish.mock(name: "Té Verde")
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(dishes))
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        let viewModel = HomeViewModel(
            getDishesUseCase: mockUseCase,
            coordinator: coordinator
        )
        
        // Espera a que los datos se carguen
        let loadExpectation = XCTestExpectation(description: "Wait for dishes to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)
        
        // Aplica el filtro
        viewModel.searchText = "@#Cafe!!"
        
        // Espera a que Combine procese el cambio (necesario si usas debounce)
        let filterExpectation = XCTestExpectation(description: "Wait for filter")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // <- Aumenta el tiempo si es necesario
            filterExpectation.fulfill()
        }
        wait(for: [filterExpectation], timeout: 1.0)
        
        // Verifica
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "Café")
    }

    // MARK: - 🚫 Manejo de error inesperado
    func testUnexpectedErrorHandling() {
        let mockError = NSError(domain: "Test", code: 999, userInfo: nil)
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
//        let coordinator = AppCoordinator()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: coordinator)

        let expectation = XCTestExpectation(description: "Error message set")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - 🏷 Navegación a DetailView
    func testNavigateToDetail() {
        let mockUseCase = MockGetDishesUseCase(result: .success([]))
        
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
//        let coordinator = AppCoordinator()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: coordinator)
        let testDish = Dish.mock()

        viewModel.navigateToDetail(dish: testDish)
        XCTAssertEqual(coordinator.navigationPath.count, 1)
        XCTAssertEqual(coordinator.navigationPath.first, .dishDetail(testDish))
    }
}
