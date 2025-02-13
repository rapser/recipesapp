//
//  LocationDetailView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import SwiftUI

struct LocationDetailView: View {
    let dish: Dish

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(dish.name)
                .font(.title)
                .padding(.bottom, 5)

            Text("Origen: \(dish.origin)")
                .font(.headline)
                .foregroundColor(.secondary)

            Divider()

            Text("Ingredientes:")
                .font(.headline)

            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(dish.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .font(.body)
                    }
                }
            }
            .frame(maxHeight: 200)
        }
        .padding()
    }
}
