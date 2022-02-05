//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    /// Lables
    @IBOutlet var lbCityName: UILabel!
    @IBOutlet var lbWeatherDate: UILabel!
    @IBOutlet var lbTemp: UILabel!
    @IBOutlet var lbMixMaxTemp: UILabel!
    @IBOutlet var lbWeatherCondition: UILabel!
    @IBOutlet var lbWeatherForecastDate: UILabel!
    @IBOutlet var lbAirPressure: UILabel!
    @IBOutlet var lbHumidity: UILabel!
    @IBOutlet var lbWindSpeed: UILabel!
    
    /// Indicator View
    @IBOutlet var loaderView: UIActivityIndicatorView!
    
    /// Image View
    @IBOutlet var imWeatherCondition: UIImageView!
    
    // Properties
    var defaultWOID : String = Constants.defaultWOID
    
    lazy var viewModel = {
        WeatherViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbCityName.text = Constants.defaultCityTitle
        initViewModel()
    }
    
    
    func initViewModel() {
        loaderView.startAnimating()
        viewModel.getWeather(woid: defaultWOID)
    }
    
    private func updateUI (weather: WeatherDetailsViewModel) {
        
        loaderView.stopAnimating()
        
        let tomorrowTemp = Int (weather.theTemp.rounded())
        let tommorrowMin = Int (weather.minTemp.rounded())
        let tommorrowMax = Int (weather.maxTemp.rounded())
        
        lbWeatherCondition.text = weather.weatherStateName
        lbTemp.text = String(tomorrowTemp) +  Constants.tempUnit
        lbMixMaxTemp.text = String(tommorrowMin) + Constants.tempUnit + Constants.textSeperation + String(tommorrowMax) + Constants.tempUnit
        lbWeatherForecastDate.text = weather.applicableDate.toDate(formatType: Constants.serverDateFormat)?.toString(formatType: Constants.dateFormat)
        
        lbAirPressure.text = String(weather.airPressure) + Constants.airPressureUnit
        lbHumidity.text = String(weather.humidity) + Constants.humidityLevel
        lbWindSpeed.text = String(weather.windSpeed.rounded()) + Constants.windSpeedUnit
        
        if let weatherConditionIconURL = URL(string:Constants.imageBaseURL + weather.weatherStateAbbr + Constants.imageType){
            imWeatherCondition.load(url: weatherConditionIconURL)
        }
        
    }
    
    // MARK :- Custom Actions
    @IBAction func actChangeCity(_ sender: UIButton) {
        
        if let citySelectionVC = Constants.mainStoryboard.instantiateViewController(withIdentifier: Constants.citySelectionVC) as? CitySelectionViewController {
            citySelectionVC.delegate = self
            self.navigationController?.pushViewController(citySelectionVC, animated: false)
        }
    }
}

extension WeatherViewController: CitySelectionDelegate {
    
    func selectedCity(_ city: CityCellViewModel) {
        lbCityName.text = city.city
        self.viewModel.getWeather(woid: city.woeid)
    }
}


extension WeatherViewController: WeatherViewModelDelegate {
    
    func apiError(error: Error) {
        
    }
    
    
    func loadData(weather: WeatherDetailsViewModel) {
        updateUI(weather: weather)
    }
}
