//
//  MovieDetailsViewModel.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation
import SwiftUI

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var errorMessage: String?

    func fetchData(id: Int) {
        guard let url = URL(string: "\(Constants.baseURl)/movie/\(id)?api_key=\(Constants.apiKey)&language=en-US") else {
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
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    self?.movie = result
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
