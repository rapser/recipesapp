//
//  AppCoordinatorTests.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import XCTest

final class AppCoordinatorTests: XCTestCase {
    
    // ✅ Caso de éxito: Navegar a una ruta agrega correctamente la ruta al navigationPath
    func testPushRoute() {
//        let coordinator = AppCoordinator()
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        coordinator.push(.home)
        
        XCTAssertEqual(coordinator.navigationPath.count, 1)
        XCTAssertEqual(coordinator.navigationPath.first, .home)
    }
    
    // ✅ Caso de éxito: popToRoot elimina todas las rutas, volviendo al estado inicial
    func testPopToRoot() {
//        let coordinator = AppCoordinator()
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)

        let mockDish = Dish.mock()
        
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        coordinator.popToRoot()
        
        XCTAssertTrue(coordinator.navigationPath.isEmpty)
    }
    
    // ✅ Caso de éxito: push múltiples veces agrega rutas en orden correcto
    func testPushMultipleRoutes() {
//        let coordinator = AppCoordinator()
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)

        let mockDish = Dish.mock()
        
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        coordinator.push(.map(mockDish))
        
        XCTAssertEqual(coordinator.navigationPath.count, 3)
        XCTAssertEqual(coordinator.navigationPath[0], .home)
        XCTAssertEqual(coordinator.navigationPath[1], .dishDetail(mockDish))
        XCTAssertEqual(coordinator.navigationPath[2], .map(mockDish))
    }
    
    // ✅ Caso de éxito: pop elimina solo la última ruta agregada
    func testPopRoute() {
//        let coordinator = AppCoordinator()
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)

        let mockDish = Dish.mock()
        
        coordinator.push(.home)
        coordinator.push(.dishDetail(mockDish))
        
        coordinator.pop()
        
        XCTAssertEqual(coordinator.navigationPath.count, 1)
        XCTAssertEqual(coordinator.navigationPath.first, .home)
    }
    
    // ⚠️ Caso borde: pop en un navigationPath vacío no debe fallar ni modificar el estado
    func testPopOnEmptyNavigationPath() {
//        let coordinator = AppCoordinator()
        let mockDependencies = MockAppDependencies()
        let coordinator = AppCoordinator(dependencies: mockDependencies)
        
        coordinator.pop()
        
        XCTAssertTrue(coordinator.navigationPath.isEmpty, "pop() en una lista vacía no debe modificar el estado")
    }
    
}

