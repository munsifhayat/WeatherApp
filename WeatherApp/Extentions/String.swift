//
//  String.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 05/02/2022.
//

import Foundation

extension String {
    
    func toDate(formatType : String)-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        let  dateFromStr = dateFormatter.date(from: self)
        return dateFromStr
    }
}
