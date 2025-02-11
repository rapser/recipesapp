//
//  SearchBarView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Busqueda", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
}
