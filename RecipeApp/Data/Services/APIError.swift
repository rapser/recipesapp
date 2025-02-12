//
//  APIError.swift
//  RecipeApp
//
//  Created by miguel tomairo on 12/02/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case clientError(code: Int)
    case serverError(code: Int)
    case decodingError
    case networkError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida."
        case .clientError:
            return "No se pudo procesar su solicitud. Intente más tarde."
        case .serverError:
            return "Problemas en el servidor. Intente más tarde."
        case .decodingError:
            return "Error procesando la respuesta."
        case .networkError:
            return "Sin conexión a internet."
        case .unknownError:
            return "Error desconocido."
        }
    }
}
