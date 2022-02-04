//
//  WeatherApiTests.swift
//  WeatherAppTests
//
//  Created by Hassan on 03/02/2022.
//

import XCTest

class WeatherApiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    class MockWeatherImplementation: WeatherViewModelDelegate {
        func apiError(error: Error) {
            self.closure?(nil,error)
        }
        
        var weather: WeatherDetailsViewModel?
        var closure: ((_ weather: WeatherDetailsViewModel?, _ error: Error?)->Void)? = nil
        func loadData(weather: WeatherDetailsViewModel) {
            self.weather = weather
            self.closure?(weather, nil)
        }
    }
    
    func testGetWeather() throws {
        let mock = MockWeatherImplementation()
        let viewModel = WeatherViewModel(delegate: mock)
        let promise = expectation(description: "Get Weather Api response")
        viewModel.getWeather(woid: "44418")
        mock.closure = { (weather, error) in
            if(error != nil){
                XCTFail(error?.localizedDescription ?? "" +  " when Getting weather ")
            } else {
                promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 10)
    }
    
    func testGetWeatherFailure() throws {
        let mock = MockWeatherImplementation()
        let viewModel = WeatherViewModel(delegate: mock)
        let promise = expectation(description: "Get Weather Api response")
        viewModel.getWeather(woid: "44418")
        mock.closure = { (weather, error) in
            if(error != nil){
                XCTFail(error?.localizedDescription ?? "" +  " when Getting weather ")
            } else {
                promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 10)
    }

}
