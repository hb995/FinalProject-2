//
//  MovieSearchViewModel.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    @Published var movies: [Movies] = []
    @Published var errorMessage: String?
    private let apiKey = "fc264167046c644f09fbc182c3eff913"

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            movies = []
            return
        }

        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(formattedQuery)") else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    self?.errorMessage = "Bad response from server"
                    return
                }

                if let data = data, let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                    self?.movies = movieResponse.results
                } else {
                    self?.errorMessage = "Error parsing the JSON data"
                }
            }
        }.resume()
    }
}

struct MovieResponse: Codable {
    let results: [Movies]
}
