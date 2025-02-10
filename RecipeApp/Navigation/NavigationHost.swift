//
//  NavigationHost.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct NavigationHost<Route: Hashable, Content: View, Destination: View>: View {
    @Binding var path: [Route]
    let root: Content
    let destinations: (Route) -> Destination

    var body: some View {
        NavigationStack(path: $path) {
            root
                .navigationDestination(for: Route.self) { route in
                    destinations(route)
                }
        }
    }
}
