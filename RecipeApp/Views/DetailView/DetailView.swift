//
//  DetailView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI

struct DetailView: View {
    let dish: Dish
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // 📸 Imagen centrada
                    AsyncImage(url: URL(string: dish.photo)) { phase in
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
                    Text(dish.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // 📝 Descripción justificada
                    Text(dish.description)
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
                            ForEach(dish.ingredients, id: \.self) { ingredient in
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
                coordinator.push(.map(dish))
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
        .navigationTitle(dish.name)
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    let dish = Dish(
        name: "Sopa a la minuta",
        photo: "https://www.recetasnestle.com.pe/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/78e3eee085a9685a8ddf003539dade14.webp?itok=NN5Zl_8v",
        description: "Aderezar la cebolla en aceite, colocar a hervir todo",
        ingredients: ["sopa", "papa", "camote", "yuca"],
        origin: "San Francisco, CA",
        location: Location(lat: 37.7749, lng: -122.4194)
    )
    
    let coordinator = AppCoordinator() // ✅ Crear instancia del coordinador

    return DetailView(dish: dish)
        .environmentObject(coordinator) // ✅ Inyectarlo correctamente
}


