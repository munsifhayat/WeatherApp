//
//  CitiesTests.swift
//  WeatherAppTests
//
//  Created by Hassan on 03/02/2022.
//

import XCTest

class CitiesTests: XCTestCase {

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
    
    func testReadCitiesFromJsonFile() throws {
        let model = CitiesViewModel()
        let jsonData = model.readLocalJSONFile(forName: "CitiesList")
        XCTAssertNotNil(jsonData)
    }
    
    
    func testReadCitiesFromJsonFileFailure() throws {
        let model = CitiesViewModel()
        let jsonData = model.readLocalJSONFile(forName: "DummyName")
        XCTAssertNil(jsonData)
    }
    
    func testGetCitiesList() throws {
        let model = CitiesViewModel()
        let promise = expectation(description: "Getting Cities List")
        model.reloadTableView = {
            promise.fulfill()
        }
        model.onError = {error in
            XCTFail(error.localizedDescription)
        }
        model.getEmployees()
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParseCityModel() throws {
        let model = CitiesViewModel()
        let mockObjects = cityRecords.getMockJson()
        let encodedData = try! JSONEncoder().encode(mockObjects)
        let parsedData = model.parse(jsonData: encodedData)
        print("parsedData",parsedData)
        XCTAssertNotNil(parsedData)
    }
    
    func testParseCityModelFailure() throws {
        let model = CitiesViewModel()
        let parsedData = model.parse(jsonData: Data())
        print("parsedData",parsedData)
        XCTAssertNil(parsedData)
    }
}
