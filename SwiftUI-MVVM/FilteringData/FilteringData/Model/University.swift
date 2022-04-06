//
//  University.swift
//  FilteringData
//
//  Created by Chhaya on 4/4/22.
//

import Foundation

struct University: Decodable {
    let country: String
    let name: String
    let domains: [String]
    let alpha_two_code : String
    let web_pages: [String]
}
