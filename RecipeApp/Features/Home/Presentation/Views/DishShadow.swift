//
//  DishShadow.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

import SwiftUI

struct DishShadow: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
            startPoint: .bottom,
            endPoint: .top
        )
        .frame(height: 50) // Altura de la sombra
        .frame(maxWidth: .infinity)
    }
}
