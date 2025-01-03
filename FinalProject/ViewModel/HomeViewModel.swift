//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var items: [Movie]?
    @Published var errorMessage: String?
    
    let placeholders = Array(repeating: Movie(id: Int(UUID().uuidString), overview: nil, title: nil), count: 10)

    func fetchData(sortBy: String, genreId: Int? = nil) {
        var urlString = "\(Constants.baseURl)/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=\(sortBy)&include_adult=false&include_video=false&page=1"
        
        if let genreId = genreId {
            urlString += "&with_genres=\(genreId)"
        }

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.handleError(error, data: data)
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }

                do {
                    let result = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                    self?.items = result.results
                } catch {
                    self?.errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func handleError(_ error: Error, data: Data?) {
        if let data = data {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                errorMessage = errorResponse.status_message
            } catch {
                errorMessage = error.localizedDescription
            }
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
