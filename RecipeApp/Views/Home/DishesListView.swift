//
//  DishesListView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct DishesListView: View {
    let dishes: [Dish]
    let onDishSelected: (Dish) -> Void
    
    var body: some View {
        List(dishes) { dish in
            DishRowView(dish: dish) {
                onDishSelected(dish)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}
