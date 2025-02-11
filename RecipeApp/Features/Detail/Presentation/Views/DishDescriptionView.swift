//
//  DishDescriptionView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

struct DishDescriptionView: View {
    let description: String

    var body: some View {
        Text(description)
            .font(.body)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(nil)
    }
}
