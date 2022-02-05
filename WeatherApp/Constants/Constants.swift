//
//  Constants.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import UIKit

struct Constants {
    
    // MARK: - URL's
    
    static let BaseURL              = "https://www.metaweather.com/api/"
    static let imageBaseURL         = "https://www.metaweather.com/static/img/weather/png/"
    
    
    // MARK:- Storyboard Identifiers
    static let mainStoryboard       = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK:- Controllers Identifiers
    // Registration
    static let citySelectionVC      = "CitySelectionVC"
    
    // MARK: - Cell Identifiers
    
    static let prodcutsCellVC       = "ProdcutsCellVC"
    
    // Titles
    static let citySelectionTitle   = "Select City"
    
    // Default City Title
    static let defaultCityTitle     = "London"
    static let defaultWOID          = "44418"
    
    static let airPressureUnit      = " psi"
    static let windSpeedUnit        = " mph"
    static let tempUnit             = "°C"
    static let humidityLevel        = " %"
    static let textSeperation       = " / "
    
    
    static let dateFormat           = "EEEE, MMM d, yyyy"
    static let serverDateFormat     = "YYYY-MM-dd"
    static let imageType            = ".png"
    
    static let citiesFileName       = "CitiesList"
    
    
    
    
    
}
