//
//  DishCard.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI
import Kingfisher

struct DishCard: View {
    let dish: Dish
    let onDishSelected: (Dish) -> Void

    var body: some View {
        Button(action: {
            onDishSelected(dish)
        }) {
            VStack {
                KFImage(URL(string: dish.photo))
                    .placeholder {
                        ZStack {
                            ProgressView()
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        DishOverlay(name: dish.name)
                    }
                    .frame(width: UIScreen.main.bounds.width / 2 - 20, height: nil)
                    .aspectRatio(0.7, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            }
            .contentShape(Rectangle())
            .accessibilityLabel("Plato: \(dish.name)")
            .accessibilityHint("Tap para ver detalles")
        }
        .buttonStyle(PlainButtonStyle())
    }
}
