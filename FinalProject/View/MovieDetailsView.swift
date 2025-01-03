//
//  MovieDetailsView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct MovieDetailsView: View {
    var item: Movie
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    @Environment(\.presentationMode) var presentation

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                movieImage
                movieDetails
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchData(id: item.id!)
        }
    }

    private var movieImage: some View {
        AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdrop_path ?? "")")) { image in
            image
                .image?.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .clipped()
                .overlay(backdropOverlay)
        }
    }

    private var backdropOverlay: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 32))
                        .foregroundColor(Color("yellow"))
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 40)
            
            Spacer()
            
            Text(item.title ?? "Loading...")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Text("\(viewModel.movie?.runtime ?? 0) min")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .redacted(reason: viewModel.movie?.runtime == nil ? .placeholder : .init())
                .padding(.horizontal)
            
            genreTags
                .padding(.horizontal)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]), startPoint: .bottom, endPoint: .top))
    }

    private var genreTags: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.movie?.genres ?? [], id: \.id) { genre in
                Text(genre.name ?? "Loading...")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .redacted(reason: genre.name == nil ? .placeholder : .init())
                
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(Color("yellow"))
            }
            Spacer()
        }
    }

    private var movieDetails: some View {
        Text(viewModel.movie?.overview ?? "Loading...")
            .foregroundColor(.gray)
            .redacted(reason: viewModel.movie?.overview == nil ? .placeholder : .init())
            .padding()
    }
}
