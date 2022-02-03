//
//  Citylist.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

struct Citylist : Codable {
    let woeid: String
    let cityName : String
    
    enum CodingKeys: String, CodingKey {
        case woeid
        case cityName = "city"
    }
}

struct cityRecords : Codable {
    let cities: [Citylist]
}
