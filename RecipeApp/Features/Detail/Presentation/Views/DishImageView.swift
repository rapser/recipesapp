//
//  DishImageView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import Kingfisher
import SwiftUI

struct DishImageView: View {
    let photoURL: String

    var body: some View {
        KFImage(URL(string: photoURL))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
    }
}
