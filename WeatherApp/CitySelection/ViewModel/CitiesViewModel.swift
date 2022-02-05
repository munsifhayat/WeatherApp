//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import Foundation

final class CitiesViewModel : NSObject {
    
    var reloadTableView: (() -> Void)?
    var onError: ((_ error: Error)->Void)? = nil
    var cities = [CityList]()
   
    var cityCellViewModels = [CityCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func fetchData(cities: [CityList]) {
        self.cities = cities 
        var vms = [CityCellViewModel]()
        for city in cities {
            vms.append(createCellModel(cityDetails:city))
        }
        cityCellViewModels = vms
    }
    
    func createCellModel(cityDetails: CityList) -> CityCellViewModel {
        let woeid = cityDetails.woeid
        let cityName = cityDetails.city
        
        return CityCellViewModel(woeid: woeid, city: cityName )
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CityCellViewModel {
        return cityCellViewModels[indexPath.row]
    }
    
    
    
    func readLocalJSONFile(forName name: String) -> Data? {
        
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            self.onError?(error)
        }
        return nil
        
    }
    
    func parse(jsonData: Data) -> cityRecords? {
        do {
            let decodedData = try JSONDecoder().decode(cityRecords.self, from: jsonData)
            return decodedData
        } catch {
            self.onError?(error)
        }
        return nil
    }
    
    
    func getCities() {
        let jsonData = readLocalJSONFile(forName: Constants.citiesFileName)
        if let data = jsonData {
            if let cityDetailsData = parse(jsonData: data) {
                self.fetchData(cities: cityDetailsData.cities)
            }
        }
    }
}
