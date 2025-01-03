//
//  HomeView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

enum Tabs: Hashable {
    case home, search, feeling, recommended
}

struct HomeView: View {
    @State private var selectedTab = Tabs.home
    @ObservedObject var viewModel: RecommendationViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        FeaturedMoviesView()
                        MoviesListView(title: "Popular", sortBy: "popularity.desc")
                        MoviesListView(title: "Highest grossing movies", sortBy: "revenue.desc")
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }
                .background(Color.white)
                .navigationBarHidden(true)
                .ignoresSafeArea(.all, edges: .all)
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(Tabs.home)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tabs.search)
            
            MoodSelectorView()
                .tabItem {
                    Image(systemName: "popcorn")
                }
                .tag(Tabs.feeling)
            
            RootView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
                .tag(Tabs.recommended)
        }
    }
}
