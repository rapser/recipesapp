//
//  MockAPIService.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import Foundation
import Combine

class MockAPIService: APIServiceProtocol {
    var mockResponse: DishesResponse?
    var lastEndpoint: String?
    
    func request<T>(endpoint: String,
                    method: HTTPMethod,
                    body: Data?,
                    headers: [String : String]?) -> AnyPublisher<T, Error> {
        lastEndpoint = endpoint
        return Just(mockResponse as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
