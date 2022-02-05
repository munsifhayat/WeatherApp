//
//  Citylist.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

struct CityList : Codable {
    
    let woeid: String
    let city : String
    
}

struct cityRecords : Codable {
    
    let cities: [CityList]
    
    static func getMockJson() -> cityRecords {
        
        return cityRecords(cities: [
            CityList(woeid: "1", city: "Mock1"),
            CityList(woeid: "2", city: "Mock2"),
            CityList(woeid: "3", city: "Mock3"),
            
        ])
    }
}
