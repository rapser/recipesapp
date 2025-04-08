//
//  APIService.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Foundation
import Combine

class APIService: APIServiceProtocol {
    
    private let baseURL = Configurator.baseURL

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: "\(baseURL)/\(endpoint).json") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { urlError -> APIError in
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    return .networkError
                default:
                    return .unknownError
                }
            }
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIError.unknownError
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 400...499:
                    throw APIError.clientError(code: httpResponse.statusCode)
                case 500...599:
                    throw APIError.serverError(code: httpResponse.statusCode)
                default:
                    throw APIError.unknownError
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let decodingError = error as? DecodingError {
                    print("Decoding Error: \(decodingError)")
                    return .decodingError
                }
                return error as? APIError ?? .unknownError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
