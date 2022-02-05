//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

protocol WeatherViewModelDelegate {
    func loadData(weather: WeatherDetailsViewModel)
    func apiError(error: Error)
}

final class WeatherViewModel: NSObject {
    
    var weather = [ConsolidatedWeather]()
    var outputDelegate: WeatherViewModelDelegate?
    
    init(delegate: WeatherViewModelDelegate) {
        self.outputDelegate = delegate
    }
    
     func getWeather( woid : String) {
        let networkManager = NetworkManager()
        let endpoint = "location/\(woid)"
        guard let url = URL(string: Constants.BaseURL + endpoint) else { fatalError("Invalid URL") }
        
        // Request data from the backend
        networkManager.request(fromURL: url) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let weatherData):
                if let weatherDetails = weatherData.consolidatedWeather {
                    self.fetchData(weather: weatherDetails)
                }
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
                self.outputDelegate?.apiError(error: error)
            }
        }
    }
    
    var tommorrowWeather: WeatherDetailsViewModel? {
        if  weather.count > 1 {
            let weatherDetailObj = createWeatherModel(weatherDetails: weather[1])
            return weatherDetailObj
        }
        return nil
    }
    
    private func fetchData(weather: [ConsolidatedWeather]) {
        self.weather = weather // Cache
        if let weatherObj = self.tommorrowWeather {
            self.outputDelegate?.loadData(weather: weatherObj)
        }
    }
    
    private func createWeatherModel(weatherDetails: ConsolidatedWeather) -> WeatherDetailsViewModel {
        
        let weatherStateName = weatherDetails.weatherStateName ?? ""
        let weatherStateAbbr = weatherDetails.weatherStateAbbr ?? ""
        let theTemp = weatherDetails.theTemp ?? 0.0
        let maxTemp = weatherDetails.maxTemp ?? 0.0
        let minTemp = weatherDetails.minTemp ?? 0.0
        let windSpeed = weatherDetails.windSpeed ?? 0.0
        let airPressure = weatherDetails.airPressure ?? 0.0
        let humidity = weatherDetails.humidity ?? 0
        let applicableDate = weatherDetails.applicableDate ?? "--"
        
        
        return WeatherDetailsViewModel(weatherStateName: weatherStateName, weatherStateAbbr: weatherStateAbbr, theTemp: theTemp, maxTemp: maxTemp, minTemp: minTemp, windSpeed: windSpeed, airPressure: airPressure, humidity: humidity , applicableDate: applicableDate)
    }
    
}

