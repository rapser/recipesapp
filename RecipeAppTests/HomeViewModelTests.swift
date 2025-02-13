//
//  HomeViewModelTests.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import XCTest
import Combine
@testable import RecipeApp

final class HomeViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - ✅ Caso de éxito: Carga de platos
    func testLoadDishesSuccess() {
        // Arrange
        let mockDishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(mockDishes))
        let mockFilterUseCase = MockFilterDishesUseCase()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, filterDishesUseCase: mockFilterUseCase, coordinator: makeCoordinator())
        let expectation = expectation(description: "Dishes loaded")
        
        // Act
        viewModel.$dishes
            .dropFirst()
            .sink { dishes in
                // Assert
                XCTAssertEqual(dishes, mockDishes)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - ❌ Caso de error: Fallo en la carga de platos
    func testLoadDishesFailure() {
        // Arrange
        let mockError = NSError(domain: "Test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error en la carga"])
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        let mockFilterUseCase = MockFilterDishesUseCase()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, filterDishesUseCase: mockFilterUseCase, coordinator: makeCoordinator())
        let expectation = expectation(description: "Error message set")
        
        // Act
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Assert
                XCTAssertEqual(errorMessage, mockError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - 🔍 Filtrado por nombre
    func testSearchFilterByName() {
        // Arrange
        let dishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let viewModel = HomeViewModel(
            getDishesUseCase: MockGetDishesUseCase(result: .success(dishes)),
            filterDishesUseCase: MockFilterDishesUseCase(),
            coordinator: makeCoordinator()
        )
        let expectation = XCTestExpectation(description: "Filtering dishes")
        
        // Act
        viewModel.searchText = "Pas"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Esperamos más que el debounce
            // Assert
            XCTAssertEqual(viewModel.filteredDishes.count, 1, "Se esperaba 1 platillo después del filtrado")
            XCTAssertEqual(viewModel.filteredDishes.first?.name, "Pasta", "El platillo filtrado debería ser 'Pasta'")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
    
    // MARK: - 🧪 Filtrado ignorando mayúsculas y acentos
    func testSearchFilterIgnoresCaseAndDiacritics() {
        // Arrange
        let dishes = [
            Dish.mock(name: "Café"),
            Dish.mock(name: "PIZZA"),
            Dish.mock(name: "té Verde")
        ]
        let viewModel = HomeViewModel(
            getDishesUseCase: MockGetDishesUseCase(result: .success(dishes)),
            filterDishesUseCase: MockFilterDishesUseCase(),
            coordinator: makeCoordinator()
        )
        let expectation = expectation(description: "Esperando filtrado de platos")
        let searchQuery = "cafe"
        let expectedResult = "Café"

        var cancellables = Set<AnyCancellable>()

        // Act
        viewModel.$filteredDishes
            .dropFirst()
            .delay(for: .milliseconds(100), scheduler: RunLoop.main) // Esperar propagación de Combine
            .sink { filteredDishes in
                // Assert
                XCTAssertEqual(filteredDishes.count, 1, "Debe haber exactamente un plato filtrado")
                XCTAssertEqual(filteredDishes.first?.name, expectedResult, "El plato filtrado debe coincidir con el esperado")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = searchQuery // Asignar después de suscribirse

        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - 🚫 Manejo de error inesperado
    func testUnexpectedErrorHandling() {
        // Arrange
        let mockError = NSError(domain: "Test", code: 999, userInfo: nil)
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        let mockFilterUseCase = MockFilterDishesUseCase()
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, filterDishesUseCase: mockFilterUseCase, coordinator: makeCoordinator())
        let expectation = expectation(description: "Error message set")
        
        // Act
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Assert
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - 🏷 Navegación a DetailView
    func testNavigateToDetail() {
        // Arrange
        let mockCoordinator = makeCoordinator()
        let viewModel = HomeViewModel(getDishesUseCase: MockGetDishesUseCase(result: .success([])), filterDishesUseCase: MockFilterDishesUseCase(), coordinator: mockCoordinator)
        let testDish = Dish.mock()
        
        // Act
        viewModel.navigateToDetail(dish: testDish)
        
        // Assert
        XCTAssertEqual(mockCoordinator.navigationPath.count, 1)
        XCTAssertEqual(mockCoordinator.navigationPath.first, .dishDetail(testDish))
    }
    
    // MARK: - 🛠 Helpers
    private func makeCoordinator() -> AppCoordinator {
        return AppCoordinator(dependencies: MockAppDependencies())
    }
    
    private func waitForLoad() {
        let expectation = expectation(description: "Wait for dishes to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { expectation.fulfill() }
        wait(for: [expectation], timeout: 2.0)
    }
    
    private func waitForFilterUpdate() {
        let expectation = expectation(description: "Wait for filter update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { expectation.fulfill() }
        wait(for: [expectation], timeout: 2.0)
    }
}
