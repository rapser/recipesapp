//
//  DishCard.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

struct DishCard: View {
    let dish: Dish
    let onDishSelected: (Dish) -> Void
    let fixedHeight: CGFloat = 220

    var body: some View {
        Button(action: {
            onDishSelected(dish)
        }) {
            ZStack(alignment: .bottom) {
                DishImage(url: dish.photo)
                DishShadow()
                DishOverlay(name: dish.name)
            }
            .frame(width: UIScreen.main.bounds.width / 2 - 20, height: fixedHeight)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .contentShape(Rectangle())
            .accessibilityLabel("Plato: \(dish.name)")
            .accessibilityHint("Tap para ver detalles")
        }
        .buttonStyle(PlainButtonStyle())
    }
}
