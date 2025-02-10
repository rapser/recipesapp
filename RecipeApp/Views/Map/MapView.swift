//
//  MapView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 8/02/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let dish: Dish
    @State private var position: MapCameraPosition
    @State private var selectedMarker: Dish? = nil
    
    init(dish: Dish) {
        self.dish = dish
        _position = State(initialValue: .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: dish.location.lat, longitude: dish.location.lng),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // Ajusta el zoom aquí
        )))
    }
    
    var body: some View {
        Map(position: $position, interactionModes: .all) {
            // Usamos Annotation para personalizar el marcador y agregar gestos
            Annotation(dish.name, coordinate: CLLocationCoordinate2D(latitude: dish.location.lat, longitude: dish.location.lng)) {
                Image(systemName: "fork.knife") // Ícono de comida
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue) // Color naranja para darle un toque de comida
                    .padding(10)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle()) // Fondo circular
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2) // Borde naranja
                    )
                    .onTapGesture {
                        selectedMarker = dish // Mostrar la vista emergente al hacer clic
                    }
            }
        }
        .navigationTitle("Recipe Origin")
        .sheet(item: $selectedMarker) { dish in
            // Vista emergente cuando se selecciona el marcador
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.name)
                    .font(.title)
                    .padding(.bottom, 5)
                
                Text("Origen: \(dish.origin)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Divider() // Línea divisoria
                
                Text("Ingredients:")
                    .font(.headline)
                
                // Lista de ingredientes con ScrollView si es necesario
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(dish.ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(.body)
                        }
                    }
                }
                .frame(maxHeight: 200) // Altura máxima para el ScrollView
            }
            .padding()
            .presentationDetents([.medium]) // Tamaño del modal
        }
    }
}


#Preview {
    let dish = Dish(
        name: "Sopa a la minuta",
        photo: "https://www.recetasnestle.com.pe/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/78e3eee085a9685a8ddf003539dade14.webp?itok=NN5Zl_8v",
        description: "Aderezar la cebolla en aceite, colocar a hervir todo",
        ingredients: ["cebolla","papa","carne","aji panca","aji molido","agua","fideo","pimienta","oregano","leche"], origin: "Perú",
        location: Location(lat: -12.113, lng: -77.025)
    )
    MapView(dish: dish)
}
