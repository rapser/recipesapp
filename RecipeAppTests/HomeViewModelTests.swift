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
        // Arrange
        let mockDishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let mockUseCase = MockGetDishesUseCase(result: .success(mockDishes))
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: makeCoordinator())
        let expectation = XCTestExpectation(description: "Dishes loaded")
        
        // Act
        viewModel.$dishes
            .dropFirst()
            .sink { dishes in
                // Assert
                XCTAssertEqual(dishes, mockDishes)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - ❌ Caso de error: Fallo en la carga de platos
    func testLoadDishesFailure() {
        // Arrange
        let mockError = NSError(domain: "Test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error en la carga"])
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: makeCoordinator())
        let expectation = XCTestExpectation(description: "Error message set")
        
        // Act
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Assert
                XCTAssertEqual(errorMessage, "Error en la carga")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - 🔍 Filtrado por nombre
    func testSearchFilterByName() {
        // Arrange
        let dishes = [
            Dish.mock(name: "Pasta", ingredients: ["Tomato"]),
            Dish.mock(name: "Pizza", ingredients: ["Cheese"])
        ]
        let viewModel = HomeViewModel(getDishesUseCase: MockGetDishesUseCase(result: .success(dishes)), coordinator: makeCoordinator())
        waitForLoad()
        
        // Act
        viewModel.searchText = "Pas"
        waitForFilterUpdate()
        
        // Assert
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "Pasta")
    }
    
    // MARK: - 🧪 Filtrado ignorando mayúsculas y acentos
    func testSearchFilterIgnoresCaseAndDiacritics() {
        // Arrange
        let dishes = [Dish.mock(name: "Café"), Dish.mock(name: "PIZZA"), Dish.mock(name: "té Verde")]
        waitForLoad()
        
        // Act & Assert
        verifySearch("cafe", expected: "Café")
        verifySearch("pizza", expected: "PIZZA")
        verifySearch("Te", expected: "té Verde")
    }
    
    // MARK: - 🛠 Filtrado con caracteres extraños
    func testSearchWithSpecialCharacters() {
        // Arrange
        let dishes = [Dish.mock(name: "Café"), Dish.mock(name: "Pizza"), Dish.mock(name: "Té Verde")]
        let viewModel = HomeViewModel(getDishesUseCase: MockGetDishesUseCase(result: .success(dishes)), coordinator: makeCoordinator())
        waitForLoad()
        
        // Act
        viewModel.searchText = "@#Cafe!!"
        waitForFilterUpdate()
        
        // Assert
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, "Café")
    }
    
    // MARK: - 🚫 Manejo de error inesperado
    func testUnexpectedErrorHandling() {
        // Arrange
        let mockError = NSError(domain: "Test", code: 999, userInfo: nil)
        let mockUseCase = MockGetDishesUseCase(result: .failure(mockError))
        let viewModel = HomeViewModel(getDishesUseCase: mockUseCase, coordinator: makeCoordinator())
        let expectation = XCTestExpectation(description: "Error message set")
        
        // Act
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Assert
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - 🏷 Navegación a DetailView
    func testNavigateToDetail() {
        // Arrange
        let mockCoordinator = makeCoordinator()
        let viewModel = HomeViewModel(
            getDishesUseCase: MockGetDishesUseCase(result: .success([])),
            coordinator: mockCoordinator
        )
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
        let expectation = XCTestExpectation(description: "Wait for dishes to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }
        wait(for: [expectation], timeout: 1.0)
    }
    
    private func waitForFilterUpdate() {
        let expectation = XCTestExpectation(description: "Wait for filter update")
        DispatchQueue.main.async { expectation.fulfill() }
        wait(for: [expectation], timeout: 1.0)
    }
    
    private func verifySearch(_ query: String, expected: String) {
        let expectation = XCTestExpectation(description: "Wait for search update")
        
        let viewModel = HomeViewModel(getDishesUseCase: MockGetDishesUseCase(result: .success([Dish.mock(name: expected)])), coordinator: makeCoordinator())
        
        let cancellable = viewModel.$filteredDishes
            .dropFirst()
            .sink { dishes in
                if let firstDish = dishes.first, firstDish.name == expected {
                    expectation.fulfill()
                }
            }
        
        viewModel.searchText = query
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.filteredDishes.count, 1)
        XCTAssertEqual(viewModel.filteredDishes.first?.name, expected)
        
        cancellable.cancel()
    }

}
