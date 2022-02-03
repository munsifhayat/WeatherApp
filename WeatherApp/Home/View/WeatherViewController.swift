//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import UIKit

protocol WeatherViewDelegate {
    func cityChanged(city: CityCellViewModel)
}

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    
    lazy var viewModel = {
        WeatherViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()
    }
    
    func initViewModel() {
        viewModel.getWeather(woid: "44418")
    }
}

extension WeatherViewController: WeatherViewDelegate {

    func cityChanged(city: CityCellViewModel) {
        self.viewModel.getWeather(woid: city.woeid)
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    
    func loadData(weather: WeatherDetailsViewModel) {
        
        print(weather)
        
    }
}

