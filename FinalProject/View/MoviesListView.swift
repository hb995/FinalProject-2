//
//  MoviesListView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var title: String
    var sortBy: String
    var movies: [Movie]?

    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            titleView
            moviesScrollView
            Spacer()
        }
        .onAppear {
            if movies == nil {
                viewModel.fetchData(sortBy: sortBy)
            }
        }
    }

    private var titleView: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
    }

    private var moviesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(movies ?? viewModel.items ?? viewModel.placeholders, id: \.id) { item in
                    NavigationLink(destination: MovieDetailsView(item: item)) {
                        MovieItemView(item: item, orientation: orientation)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MovieItemView: View {
    var item: Movie
    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            movieImage
            movieInfo
        }
        .frame(width: orientation == "horizontal" ? 200 : 160)
    }

    private var movieImage: some View {
        AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\((orientation == "horizontal" ? item.backdrop_path : item.poster_path) ?? "")")) { image in
            image
                .image?.resizable()
                .scaledToFill()
                .frame(width: orientation == "horizontal" ? 200 : 160, height: orientation == "horizontal" ? 120 : 240)
                .redacted(reason: item.poster_path == nil ? .placeholder : .init())
                .cornerRadius(8)
        }
    }

    private var movieInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title ?? "Loading...")
                    .font(.system(size: orientation == "horizontal" ? 17 : 15))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .redacted(reason: item.title == nil ? .placeholder : .init())

                Text(item.overview ?? "Loading...")
                    .font(.system(size: orientation == "horizontal" ? 15 : 13))
                    .lineLimit(2)
                    .foregroundColor(.gray)
                    .redacted(reason: item.overview == nil ? .placeholder : .init())
            }
            Spacer()
        }
    }
}
