//
//  APIServiceProtocol.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func request<T: Decodable>(endpoint: String, method: HTTPMethod, body: Data?, headers: [String: String]?) -> AnyPublisher<T, Error>
}
