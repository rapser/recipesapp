//
//  Configurator.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/04/25.
//

import Foundation

class Configurator {
    
    private static let configFileName = "Config"
    
    static var baseURL: String {
        guard let urlString = readConfigValue(forKey: "BaseURL") else {
            fatalError("BaseURL no encontrado en el archivo de configuración.")
        }
        return urlString
    }
    
    private static func readConfigValue(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: configFileName, ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let configDict = try? PropertyListSerialization.propertyList(from: xml, options: [], format: nil) as? [String: Any] else {
            return nil
        }
        return configDict[key] as? String
    }
}
