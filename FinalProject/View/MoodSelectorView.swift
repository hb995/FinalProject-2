//
//  MoodSelectorView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct MoodSelectorView: View {
    // Mapping moods to their corresponding genre IDs
    let moods: [String: Int] = [
        "In for a thrill": 27,    // Thriller
        "Feeling romantic": 10749, // Romance
        "Need a laugh": 35         // Comedy
    ]

    @State private var selectedMoodId: Int? = nil
    @State private var selectedMoodName: String? = nil
    @ObservedObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            Text("Select Your Mood")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()

            // Stylish buttons for moods
            ForEach(moods.keys.sorted(), id: \.self) { mood in
                Button(action: {
                    self.selectedMoodId = moods[mood]
                    self.selectedMoodName = mood
                    if let selectedMoodId = selectedMoodId {
                        viewModel.fetchData(sortBy: "popularity.desc", genreId: selectedMoodId)
                    }
                }) {
                    Text(mood)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(selectedMoodName == mood ? Color.green : Color.blue)
                        .cornerRadius(10)
                        .font(.headline)
                        .padding(4)
                }
            }

            // Enhanced display of movies
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.items ?? viewModel.placeholders, id: \.id) { item in
                        NavigationLink(destination: MovieDetailsView(item: item)) {
                            MovieItemView(item: item, orientation: "horizontal")
                        }
                        .frame(width: 200, height: 300)
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .navigationBarTitle("Mood Selector", displayMode: .inline)
        .background(Color.white)
    }
}
