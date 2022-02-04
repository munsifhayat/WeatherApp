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
    
    static func getMockJson() -> cityRecords {
        return cityRecords(cities: [
            Citylist(woeid: "1", cityName: "Mock1"),
            Citylist(woeid: "2", cityName: "Mock2"),
            Citylist(woeid: "3", cityName: "Mock3"),
            
        ])
    }
}
