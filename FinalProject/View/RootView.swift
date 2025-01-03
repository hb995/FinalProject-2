//
//  RootView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RecommendationViewModel()
    @State private var showWelcome = true
    
    var body: some View {
        if showWelcome {
            WelcomeView(viewModel: viewModel, showWelcome: $showWelcome)
        } else {
            
            VStack {
                Spacer() 
                
                MoviesListView(title: "Recommended for You", sortBy: "", movies: viewModel.recommendedMovies, orientation: "vertical")
                    .onAppear {
                        if viewModel.recommendedMovies.isEmpty {
                            viewModel.fetchMoviesBasedOnPreferences(genre: viewModel.selectedGenre, era: viewModel.favoriteEra)
                        }
                    }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    RootView()
}
