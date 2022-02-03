//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
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

extension Date {
    
    func toString(formatType : String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        let  dateFromStr = dateFormatter.string(from: self)
        return dateFromStr
    }
}
