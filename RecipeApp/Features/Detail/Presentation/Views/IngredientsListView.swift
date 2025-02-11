//
//  IngredientsListView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

struct IngredientsListView: View {
    let ingredients: [String]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ingredientes:")
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .font(.body)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxHeight: .infinity) // Ocupa todo el espacio disponible
    }
}
