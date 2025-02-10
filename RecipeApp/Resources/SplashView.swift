//
//  SplashScreenView.swift
//  RecipeApp
//
//  Created by miguel tomairo on 9/02/25.
//

import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0
    @State private var textOffsetY: CGFloat = 30
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                
                Text("Dishes")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y: textOffsetY)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                logoScale = 1.3
                logoOpacity = 1
                textOffsetY = 0
            }
            
            withAnimation(.easeInOut(duration: 0.8).delay(1.0)) {
                logoScale = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    showSplash = false
                }
            }
        }
    }
}

