//
//  View+Extension.swift
//  RecipeApp
//
//  Created by miguel tomairo on 10/02/25.
//

import SwiftUI

extension View {
    func errorAlert(errorMessage: Binding<String?>) -> some View {
        alert("Error", isPresented: .constant(errorMessage.wrappedValue != nil)) {
            Button("OK") {
                errorMessage.wrappedValue = nil
            }
        } message: {
            Text(errorMessage.wrappedValue ?? "")
        }
    }

    func errorAlert(errorMessage: Binding<String?>, retryAction: @escaping () -> Void) -> some View {
        alert("Error", isPresented: .constant(errorMessage.wrappedValue != nil)) {
            Button("Cancelar", role: .cancel) {
                errorMessage.wrappedValue = nil
            }
            Button("Reintentar") {
                errorMessage.wrappedValue = nil
                retryAction()
            }
        } message: {
            Text(errorMessage.wrappedValue ?? "Ha ocurrido un error inesperado.")
        }
    }
}
