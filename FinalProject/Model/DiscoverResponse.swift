//
//  DiscoverResponse.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

struct DiscoverResponse: Decodable {
    var page: Int?
    var results: [Movie]?
    var totalResults: Int?
    var totalPages: Int?
}
