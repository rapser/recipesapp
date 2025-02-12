//
//  DishSkeletonView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 12/02/25.
//

import SwiftUI

struct DishSkeletonView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.3))
                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 200)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 15)
                .shimmer()
        }
        .padding(.bottom, 10)
    }
}
