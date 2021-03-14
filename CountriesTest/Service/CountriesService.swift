//
//  CountriesService.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//

import Foundation
import Alamofire

typealias CountriesCompletion = (Result<[Country],Error>) ->()

protocol CountriesApi {
    func getCountries(completion: @escaping CountriesCompletion) 
}

class CountriesService : CountriesApi {
    private let baseUrl: String = "https://restcountries.eu/rest/v2/all"
    private let fields = "?fields=\(["name","nativeName","area","borders","alpha3Code"].joined(separator: ";"))"
    
    func getCountries(completion: @escaping CountriesCompletion) {
        AF.request("\(self.baseUrl)\(fields)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            response in
            if let error = response.error {
                completion(.failure(error))
            }
            guard let data = response.data else {
                return
            }
            do {
                let response = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

