//
//  DishesRepository.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Combine
import SwiftUI

final class DishesRepository: DishesRepositoryProtocol {
    private let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    func fetchDishes() -> AnyPublisher<DishesResponse, Error> {
        return service.request(endpoint: "recipes", method: .GET, body: nil, headers: nil)
            .eraseToAnyPublisher()
    }
}

