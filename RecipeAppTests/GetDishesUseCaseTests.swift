//
//  GetDishesUseCaseTests.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import XCTest
import Combine

final class GetDishesUseCaseTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    // ✅ Caso de éxito: Devuelve una lista de platos correctamente
    func testExecuteSuccess() {
        // 1. Crea un Dish de prueba usando el mock
        let mockDish = Dish.mock()
        
        // 2. Construye la respuesta del API (DishesResponse)
        let mockDishesResponse = DishesResponse(dishes: [mockDish])
        
        // 3. Simula una respuesta exitosa del repositorio
        let mockRepository = MockDishesRepository(
            result: .success(mockDishesResponse)
        )
        
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Dishes received successfully")
        
        // 4. Ejecuta el UseCase y valida la respuesta
        useCase.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { dishes in
                    XCTAssertEqual(dishes.count, 1)
                    XCTAssertEqual(dishes.first?.location.lat, 0.0)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // ❌ Caso de error: El repositorio falla y devuelve un error
    func testExecuteFailure() {
        // 1. Simula un error en el repositorio
        let mockError = NSError(domain: "TestError", code: 500, userInfo: nil)
        let mockRepository = MockDishesRepository(
            result: .failure(mockError)
        )
        
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Error received")

        // 2. Ejecuta el UseCase y verifica que se propaga el error
        useCase.execute()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Expected failure but received value")
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // ⚠️ Caso de error: La respuesta del API está vacía
    func testExecuteEmptyResponse() {
        // 1. Simula una respuesta vacía del API
        let mockDishesResponse = DishesResponse(dishes: [])
        let mockRepository = MockDishesRepository(
            result: .success(mockDishesResponse)
        )
        
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Empty list received")

        // 2. Ejecuta el UseCase y valida que la lista está vacía
        useCase.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { dishes in
                    XCTAssertEqual(dishes.count, 0, "The dishes list should be empty")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
