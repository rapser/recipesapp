//
//  MapAnnotationView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 11/02/25.
//

import SwiftUI

struct MapAnnotationView: View {
    let dishName: String
    let action: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding(10)
                .background(Color.white.opacity(0.9))
                .clipShape(Circle()) // Fondo circular
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            Text(dishName)
                .font(.caption)
                .foregroundColor(.black)
        }
        .onTapGesture {
            action()
        }
    }
}
