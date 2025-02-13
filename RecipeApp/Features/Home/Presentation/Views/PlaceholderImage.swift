//
//  PlaceholderImage.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

import SwiftUI

struct PlaceholderImage: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}
