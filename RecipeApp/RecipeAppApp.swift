//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by miguel tomairo on 7/02/25.
//

import SwiftUI
import Combine

@main
struct RecipeAppApp: App {
    @State private var showSplash = true
    @StateObject private var dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
                    .transition(.opacity)
            } else {
                NavigationHost()
                    .environmentObject(dependencies)
                    .environmentObject(dependencies.coordinator)
            }
        }
    }
}
