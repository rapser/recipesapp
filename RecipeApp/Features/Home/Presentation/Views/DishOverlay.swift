//
//  DishOverlay.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

struct DishOverlay: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.headline)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 3, x: 0, y: 0)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
    }
}
