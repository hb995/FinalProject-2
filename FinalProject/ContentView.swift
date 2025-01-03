//
//  ContentView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//


import SwiftUI
import ActivityIndicatorView


struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        ZStack {
            if isLoading {
                VStack {
                    ActivityIndicatorView(isVisible: $isLoading, type: .default())
                        .frame(width: 50.0, height: 50.0)
                        .foregroundColor(.red)

                    Text("Loading")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(20)
            } else {
                HomeView(viewModel: RecommendationViewModel())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
}
