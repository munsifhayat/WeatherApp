//
//  ConsolidatedWeather.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

public struct ConsolidatedWeather : Codable {
    
   let id : Int?
   let weatherStateName : String?
   let weatherStateAbbr : String?
   let windDirectionCompass : String?
   let created : String?
   let applicableDate : String?
   let minTemp : Double?
   let maxTemp : Double?
   let theTemp : Double?
   let windSpeed : Double?
   let windDirection : Double?
   let airPressure : Double?
   let humidity : Int?
   let visibility : Double?
   let predictability : Int?

   enum CodingKeys: String, CodingKey {

       case id = "id"
       case weatherStateName = "weather_state_name"
       case weatherStateAbbr = "weather_state_abbr"
       case windDirectionCompass = "wind_direction_compass"
       case created = "created"
       case applicableDate = "applicable_date"
       case minTemp = "min_temp"
       case maxTemp = "max_temp"
       case theTemp = "the_temp"
       case windSpeed = "wind_speed"
       case windDirection = "wind_direction"
       case airPressure = "air_pressure"
       case humidity = "humidity"
       case visibility = "visibility"
       case predictability = "predictability"
   }

    public init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       id = try values.decodeIfPresent(Int.self, forKey: .id)
       weatherStateName = try values.decodeIfPresent(String.self, forKey: .weatherStateName)
       weatherStateAbbr = try values.decodeIfPresent(String.self, forKey: .weatherStateAbbr)
       windDirectionCompass = try values.decodeIfPresent(String.self, forKey: .windDirectionCompass)
       created = try values.decodeIfPresent(String.self, forKey: .created)
       applicableDate = try values.decodeIfPresent(String.self, forKey: .applicableDate)
       minTemp = try values.decodeIfPresent(Double.self, forKey: .minTemp)
       maxTemp = try values.decodeIfPresent(Double.self, forKey: .maxTemp)
       theTemp = try values.decodeIfPresent(Double.self, forKey: .theTemp)
       windSpeed = try values.decodeIfPresent(Double.self, forKey: .windSpeed)
       windDirection = try values.decodeIfPresent(Double.self, forKey: .windDirection)
       airPressure = try values.decodeIfPresent(Double.self, forKey: .airPressure)
       humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
       visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
       predictability = try values.decodeIfPresent(Int.self, forKey: .predictability)
   }

}
