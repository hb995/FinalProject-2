//
//  RecommendationViewModel.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

class RecommendationViewModel: ObservableObject {
    @Published var selectedGenre: String = "Action"
    @Published var favoriteEra: String = "Classic (before 1980)"
    @Published var recommendedMovies: [Movie] = []

    func savePreferences() {
        fetchMoviesBasedOnPreferences(genre: selectedGenre, era: favoriteEra)
        print(recommendedMovies)
    }
    
    func fetchMoviesBasedOnPreferences(genre: String, era: String) {
        print("Yu smo")
        var components = URLComponents(string: "\(Constants.baseURl)/discover/movie")
        let queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "with_genres", value: String(mapGenreToId(genre))),
            URLQueryItem(name: "primary_release_year", value: mapEraToYear(era))
        ]
        components?.queryItems = queryItems
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                DispatchQueue.main.async {
                    self.recommendedMovies = moviesResponse.results!
                }
            } catch {
                print("Error parsing movies: \(error.localizedDescription)")
            }
        }.resume()
        print("asdihiasudai afasfad")
    }

    // Helper functions to map user preferences to API parameters
    func mapGenreToId(_ genre: String) -> Int {
        switch genre {
        case "Action":
            return 28
        case "Romance":
            return 10749
        case "Comedy":
            return 35
        case "Horror":
            return 27
        case "Sci-Fi":
            return 878
        default:
            return 0 // Return a default value for genre not found
        }
    }

    func mapEraToYear(_ era: String) -> String {
        switch era {
        case "Classic (before 1980)":
            return "year=1979&sort_by=release_date.desc"
        case "80s-90s":
            return "primary_release_date.gte=1980-01-01&primary_release_date.lte=1999-12-31"
        case "2000s":
            return "primary_release_date.gte=2000-01-01&primary_release_date.lte=2009-12-31"
        case "2010s":
            return "primary_release_date.gte=2010-01-01&primary_release_date.lte=2019-12-31"
        case "Recent":
            return "primary_release_date.gte=2020-01-01"
        default:
            return ""
        }
    }
}
