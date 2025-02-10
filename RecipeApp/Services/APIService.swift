//
//  APIService.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import Foundation
import Combine

class APIService: APIServiceProtocol {
    private let baseURL = "https://demo8302872.mockable.io"
    
    func request<T: Decodable>(endpoint: String,
                               method: HTTPMethod,
                               body: Data? = nil,
                               headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            print("Error: URL inválida")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        print("Realizando petición a: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    print("Error: Respuesta no válida")
                    throw URLError(.badServerResponse)
                }
                
                print("Código de respuesta HTTP: \(httpResponse.statusCode)")
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Error: Código de respuesta no esperado: \(httpResponse.statusCode)")
                    throw URLError(.badServerResponse)
                }
                
                if let jsonString = String(data: result.data, encoding: .utf8) {
                    print("JSON recibido: \(jsonString)")
                }
                
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
