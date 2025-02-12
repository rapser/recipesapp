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

    // MARK: - Casos de éxito

    func testExecuteSuccess() {
        // Arrange
        let mockDish = Dish.mock()
        let mockDishesResponse = DishesResponse(dishes: [mockDish])
        let mockRepository = MockDishesRepository(result: .success(mockDishesResponse))
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Dishes received successfully")
        
        // Act
        useCase.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { dishes in
                    // Assert
                    XCTAssertEqual(dishes.count, 1)
                    XCTAssertEqual(dishes.first?.location.lat, 0.0)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Casos de error

    func testExecuteFailure() {
        // Arrange
        let mockError = NSError(domain: "TestError", code: 500, userInfo: nil)
        let mockRepository = MockDishesRepository(result: .failure(mockError))
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Error received")

        // Act
        useCase.execute()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        // Assert
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

    func testExecuteEmptyResponse() {
        // Arrange
        let mockDishesResponse = DishesResponse(dishes: [])
        let mockRepository = MockDishesRepository(result: .success(mockDishesResponse))
        let useCase = GetDishesUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Empty list received")

        // Act
        useCase.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { dishes in
                    // Assert
                    XCTAssertEqual(dishes.count, 0, "The dishes list should be empty")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}

