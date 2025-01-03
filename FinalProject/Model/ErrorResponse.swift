//
//  ErrorResponse.swift
//  FinalProject
//
//  Created by Hrvoje Buljan (RIT Student) on 10.12.2023..
//

import Foundation

struct ErrorResponse: Decodable {
    var status_message: String?
    var status_code: Int?
}
