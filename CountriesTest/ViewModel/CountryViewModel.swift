//
//  CountryViewModel.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//

import Foundation

struct CountryViewModel {
    private var country: Country
    
    init(_ country: Country) {
        self.country = country
    }
    
    func getName() -> String { country.name }
    func getNativeName() -> String { return country.nativeName }
    func getArea() -> Double { country.area ?? 0 }
    func getCode() -> String {
        return self.country.alpha3Code
    }
    func getBorderCountriesCodes()-> [String] {
        return self.country.borders
    }
}


