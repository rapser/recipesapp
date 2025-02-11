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
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
