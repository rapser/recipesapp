//
//  DishesListView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct DishesListView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 15) {
                Group {
                    if viewModel.isLoading {
                        loadingSkeletons
                    } else {
                        dishList
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }

    private var loadingSkeletons: some View {
        ForEach(0..<6, id: \.self) { _ in
            DishSkeletonView()
        }
    }

    private var dishList: some View {
        ForEach(viewModel.filteredDishes, id: \.id) { dish in
            DishCard(dish: dish, onDishSelected: viewModel.navigateToDetail)
        }
    }
}


