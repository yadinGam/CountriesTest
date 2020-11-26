//
//  CountriesViewModel.swift
//  CountriesTest
//
//  Created by yadin g on 26/11/2020.
//

import Foundation

typealias CountryViewModelCompletion = (Result<CountriesViewModel,Error>) ->()

enum SortType {
    case area
    case name
}

class CountriesViewModel {
    private var service : CountriesApi = CountriesService()
    
    private var countries: [Country] = [Country]() {
        didSet { self.countryViewModels = countries.map( { CountryViewModel($0) } ) }
    }
    func set(countries: [Country]) {
        self.countries = countries
    }
    
    private var countryViewModels = [CountryViewModel]()
    
    init(service: CountriesApi = CountriesService()) {
        self.service = service
    }
    
    init(countries : [Country]) {
        self.countries = countries
        self.countryViewModels = countries.map( { CountryViewModel($0) } )
    }
    
    func sort(by sortType : SortType) {
        switch sortType {
        
        case .area:
            self.countries = self.countries.sorted(by: {$0.area ?? 0 > $1.area ?? 0})
        case .name:
            self.countries = self.countries.sorted(by: {$0.name > $1.name})
        }
    
    }
    
    func numberOfItems() -> Int {
        return countries.count
    }
    
    func countryViewModel(at index: Int) -> CountryViewModel? {
        return self.countryViewModels[index]
    }
    
    func getCountries(completion : @escaping CountryViewModelCompletion) {
        self.service.getCountries { (result) in
            switch result {
            case .success(let countries):
                self.countries = countries
                completion(.success(self))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNeighborCountries(for index: Int) -> [Country] {
        let selectedCountry = countries[index]
        var neighborCountries = [Country]()
        for neighborCountryCode in selectedCountry.borders {
            for country in self.countries {
                if country.alpha3Code == neighborCountryCode {
                    neighborCountries.append(country)
                }
            }
        }
        return neighborCountries
    }
}


