//
//  Movie.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

struct Movie: Identifiable, Decodable {
    var backdrop_path: String?
    var id: Int?
    var genres: [Genre]?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var runtime: Int?
    var title: String?
}
