//
//  Country.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//

import Foundation

struct Country : Codable {
    let name: String
    let nativeName: String
    let area: Double?
    let borders: [String]
    let alpha3Code: String
}
