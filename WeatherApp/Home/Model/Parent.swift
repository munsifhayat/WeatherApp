//
//  Parent.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

struct Parent : Codable {
    let title : String?
    let locationType : String?
    let woeid : Int?
    let lattLong : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case locationType = "location_type"
        case woeid = "woeid"
        case lattLong = "latt_long"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        lattLong = try values.decodeIfPresent(String.self, forKey: .lattLong)
    }

}
