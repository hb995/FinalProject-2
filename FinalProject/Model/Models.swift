//
//  Models.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

struct Movies: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    var poster_path: String?
    var backdrop_path: String?
    var release_date: String?
    var runtime: Int?
}
