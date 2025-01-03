//
//  FeaturedMoviesView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct FeaturedMoviesView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var pageSelected: Int = 0

    var body: some View {
        ZStack {
            if let items = viewModel.items {
                TabView(selection: $pageSelected) {
                    ForEach(0..<min(items.count, 5), id: \.self) { index in
                        FeaturedTab(item: items[index], index: index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }

            VStack {
                FeaturedMoviesHeader()

                Spacer()

                PageIndicator(count: 5, currentPage: $pageSelected)
                    .padding(.bottom, 30)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .onAppear {
            viewModel.fetchData(sortBy: "vote_count.desc")
        }
    }
}

struct FeaturedTab: View {
    let item: Movie
    let index: Int

    var body: some View {
        NavigationLink(destination: MovieDetailsView(item: item)) {
            ZStack(alignment: .bottomLeading) {
                MovieImage(item: item, index: index)
                MovieInfo(item: item)
                    .padding(.bottom, 40)
            }
        }
    }
}

struct FeaturedMoviesHeader: View {
    var body: some View {
        HStack {
            Text("Movie")
                .movieTitleStyle()
            Text("App")
                .movieTitleStyle(foreground: .white)
        }
        .padding(.horizontal)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
    }
}

struct PageIndicator: View {
    let count: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .frame(width: 22, height: 6)
                    .foregroundColor(currentPage == index ? .yellow : .gray)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]), startPoint: .bottom, endPoint: .top))
    }
}

struct MovieImage: View {
    let item: Movie
    let index: Int

    var body: some View {
        AsyncImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdrop_path ?? "")")) { image in
            image
                .image?.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .tag(index)
        }
    }
}

struct MovieInfo: View {
    let item: Movie

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title ?? "Loading...")
                .movieInfoStyle(size: 19, weight: .bold, color: .white, redacted: item.title == nil)
            
            Text(item.release_date ?? "Loading...")
                .movieInfoStyle(size: 17, weight: .bold, color: .gray, redacted: item.release_date == nil)
        }
        .padding(.leading)
    }
}

extension Text {
    func movieTitleStyle(foreground: Color = .white) -> some View {
        self.font(.title)
            .fontWeight(.bold)
            .foregroundColor(foreground)
            .padding(.leading, 8)
    }

    func movieInfoStyle(size: CGFloat, weight: Font.Weight, color: Color, redacted: Bool) -> some View {
        self.font(.system(size: size))
            .fontWeight(weight)
            .foregroundColor(color)
            .redacted(reason: redacted ? .placeholder : .init())
    }
}

struct FeaturedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FeaturedMoviesView()
            Spacer()
        }
        .background(Color.black.opacity(0.05))
        .ignoresSafeArea(.all, edges: .top)
    }
}
#Preview {
    FeaturedMoviesView()
}
