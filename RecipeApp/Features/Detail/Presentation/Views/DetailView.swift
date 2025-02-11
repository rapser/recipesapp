//
//  DetailView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

struct DetailView: View {    
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // 📸 Imagen centrada
                    AsyncImage(url: URL(string: viewModel.dish.photo)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    // 📌 Nombre del plato
                    Text(viewModel.dish.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // 📝 Descripción justificada
                    Text(viewModel.dish.description)
                        .font(.body)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil)
                    
                    // 🛒 Ingredientes con scroll interno si hay muchos
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.dish.ingredients, id: \.self) { ingredient in
                                Text("• \(ingredient)")
                                    .font(.body)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 150)
                }
            }
            
            // 📍 Botón que usa el `coordinator` para abrir el mapa
            Button(action: {
                viewModel.navigateToMap()
            }) {
                Text("View on Map")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .padding(.bottom, 10)
        }
        .navigationTitle(viewModel.dish.name)
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    DetailView(viewModel: .preview())
        .environmentObject(AppCoordinator())
}

