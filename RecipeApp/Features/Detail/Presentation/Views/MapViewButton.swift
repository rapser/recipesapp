//
//  MapViewButton.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

struct MapViewButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Ver en el Mapa")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .padding(.bottom, 10)
    }
}
