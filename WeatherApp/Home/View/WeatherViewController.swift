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
    
    @IBOutlet var lbAirPressure: UILabel!
    @IBOutlet var lbHumidity: UILabel!
    @IBOutlet var lbWindSpeed: UILabel!

    
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

        initViewModel()
    }
    
    func initViewModel() {
        viewModel.getWeather(woid: defaultWOID)
    }
    
    // Update UI with Data
    
    private func updateUI (weather: WeatherDetailsViewModel) {
        
        lbWeatherCondition.text = weather.weather_state_name
        lbTemp.text = String(weather.the_temp)
        lbMixMaxTemp.text = String(weather.min_temp) + "/" + String(weather.max_temp)
        
        lbAirPressure.text = String(weather.air_pressure)
        lbHumidity.text = String(weather.humidity) + "%"
        lbWindSpeed.text = String(weather.wind_speed)

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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } else {
                print("Nothing")
            }
        }
    }
}

