//
//  WelcomeView.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import SwiftUI

struct WelcomeView: View {
    @State private var currentStep = 1
    @ObservedObject var viewModel: RecommendationViewModel
    @Binding var showWelcome: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Movie App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Tell us what you like and we'll find the best movies for you!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()

                // Questionnaire
                Group {
                    switch currentStep {
                    case 1:
                        QuestionView(question: "Which genre do you prefer?",
                                     options: ["Action", "Romance", "Comedy", "Horror", "Sci-Fi"],
                                     selection: $viewModel.selectedGenre)
                    default:
                        Text("Thank you!")
                    }
                }
                .transition(.slide)

                // Next button
                Button(action: {
                    if currentStep < 2 {
                        withAnimation {
                            currentStep += 1
                        }
                    } else {
                        viewModel.savePreferences()
                        showWelcome = false
                    }
                }) {
                    Text(currentStep < 2 ? "Next" : "Finish")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

// Helper view for displaying a question
struct QuestionView: View {
    let question: String
    let options: [String]
    @Binding var selection: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.headline)
            Picker(question, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
