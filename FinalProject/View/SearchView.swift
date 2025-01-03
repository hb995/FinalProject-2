//
//  SearchView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = MovieSearchViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(movie.poster_path ?? "")")) { image in
                        image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: 200)
                    }
                    Text(movie.title)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("Movie Search")
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                if !searchText.isEmpty{
                    viewModel.searchMovies(query: newValue)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
