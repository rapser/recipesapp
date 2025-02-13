//
//  DishImage.swift
//  RecipeApp
//
//  Created by miguel tomairo on 13/02/25.
//

import SwiftUI
import Kingfisher

struct DishImage: View {
    let url: String

    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                PlaceholderImage()
            }
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}
