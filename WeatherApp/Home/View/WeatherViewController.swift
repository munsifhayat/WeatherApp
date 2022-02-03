//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
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
    
    @IBOutlet var loaderView: UIActivityIndicatorView!

    
    
    /// Image View
    @IBOutlet var imWeatherCondition: UIImageView!
    
    // Properties
    var selectedCity : String = "London"
    var defaultWOID : String = "44418"
    
    
    lazy var viewModel = {
        WeatherViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbCityName.text = "London"
        
        initViewModel()
    }
    
    
    
    func initViewModel() {
        loaderView.startAnimating()
        viewModel.getWeather(woid: defaultWOID)
    }
    
    private func updateUI (weather: WeatherDetailsViewModel) {
        
        loaderView.stopAnimating()
        
        let tomorrowTemp = Int (weather.the_temp.rounded())
        let tommorrowMin = Int (weather.min_temp.rounded())
        let tommorrowMax = Int (weather.max_temp.rounded())

        lbWeatherCondition.text = weather.weather_state_name
        lbTemp.text = String(tomorrowTemp) +  "°C"
        lbMixMaxTemp.text = String(tommorrowMin) + "°C" + " / " + String(tommorrowMax) + "°C"
        lbWeatherForecastDate.text = weather.applicable_date.toDate(formatType: "YYYY-MM-dd")?.toString(formatType: "EEEE, MMM d, yyyy")
        
        
        lbAirPressure.text = String(weather.air_pressure) + " psi"
        lbHumidity.text = String(weather.humidity) + " %"
        lbWindSpeed.text = String(weather.wind_speed.rounded()) + " mph"
        
        if let weatherConditionIconURL = URL(string:Constants.imageBaseURL + weather.weather_state_abbr + ".png"){
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
        lbCityName.text = city.cityName
        self.viewModel.getWeather(woid: city.woeid)
    }
}



extension WeatherViewController: WeatherViewModelDelegate {
    
    func loadData(weather: WeatherDetailsViewModel) {
        updateUI(weather: weather)
    }
}
