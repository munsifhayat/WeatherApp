//
//  CitySelectionViewController.swift
//  WeatherApp
//
//  Created by Munsif Hayat on 03/02/2022.
//

import UIKit

protocol CitySelectionDelegate : AnyObject {
    
    func selectedCity(_ city: CityCellViewModel)
}

class CitySelectionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
//    var weatherDelegate: WeatherViewDelegate?
    
    weak var delegate: CitySelectionDelegate?

    
    lazy var viewModel = {
        CitiesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select City"
        
        initView()
        initViewModel()
    }
    
    func initView() {
        // TableView customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(CitySelectionCell.nib, forCellReuseIdentifier: CitySelectionCell.identifier)
    }
    
    func initViewModel() {
        viewModel.getEmployees()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDelegate

extension CitySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDataSource

extension CitySelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionCell.identifier, for: indexPath) as? CitySelectionCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        self.delegate?.selectedCity(cellVM)
        self.navigationController?.popViewController(animated: true)
    }
}
