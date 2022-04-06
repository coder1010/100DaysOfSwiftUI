//
//  Hotel.swift
//  FilteringData
//
//  Created by Admin on 4/3/22.
//

import Foundation

struct Hotel: Decodable {
    let id: Int
    let title: String
    let photUrl: String
    let rating: Double?
    let price: Double
}
