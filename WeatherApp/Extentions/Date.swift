//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

extension Date {
    
    func toString(formatType : String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        let  dateFromStr = dateFormatter.string(from: self)
        return dateFromStr
    }
}
