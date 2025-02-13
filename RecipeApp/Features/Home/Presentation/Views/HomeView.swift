//
//  HomeView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                DishesListView(viewModel: viewModel)
            }
            .navigationTitle("Recetas")
            .errorAlert(errorMessage: $viewModel.errorMessage, retryAction: {
                viewModel.retryLoading()
            })
        }
    }
}

#Preview {        
    HomeView(viewModel: .preview())
}
