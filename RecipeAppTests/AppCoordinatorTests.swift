//
//  AppCoordinatorTests.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import XCTest

final class AppCoordinatorTests: XCTestCase {
    
    // MARK: - Navegación

    func testPushRoute() {
        // Arrange
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        // Act
        coordinator.push(.home)
        
        // Assert
        XCTAssertEqual(coordinator.navigationPath.count, 1)
        XCTAssertEqual(coordinator.navigationPath.first, .home)
    }
    
    func testPopToRoot() {
        // Arrange
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        let mockDish = Dish.mock()
        
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        
        // Act
        coordinator.popToRoot()
        
        // Assert
        XCTAssertTrue(coordinator.navigationPath.isEmpty)
    }
    
    func testPushMultipleRoutes() {
        // Arrange
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        let mockDish = Dish.mock()
        
        // Act
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        coordinator.push(.map(mockDish))
        
        // Assert
        XCTAssertEqual(coordinator.navigationPath.count, 3)
        XCTAssertEqual(coordinator.navigationPath[0], .home)
        XCTAssertEqual(coordinator.navigationPath[1], .dishDetail(mockDish))
        XCTAssertEqual(coordinator.navigationPath[2], .map(mockDish))
    }
    
    func testPopRoute() {
        // Arrange
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        let mockDish = Dish.mock()
        
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        
        // Act
        coordinator.pop()
        
        // Assert
        XCTAssertEqual(coordinator.navigationPath.count, 1)
        XCTAssertEqual(coordinator.navigationPath.first, .home)
    }
    
    func testPopOnEmptyNavigationPath() {
        // Arrange
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        // Act
        coordinator.pop()
        
        // Assert
        XCTAssertTrue(coordinator.navigationPath.isEmpty, "pop() en una lista vacía no debe modificar el estado")
    }
}

