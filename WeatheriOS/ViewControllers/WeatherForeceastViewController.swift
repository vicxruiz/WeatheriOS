//
//  WeatherForeceastViewController.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

class WeatherForecastViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var forecasts: [ForecastDay] = []
    var enteredText = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setTableView()
    }
    
}

extension WeatherForecastViewController: UISearchBarDelegate {
    func setSearchBar() {
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Enter City"
        hideKeyboardWhenTappedAround()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.enteredText = searchBar.text ?? ""
        makeSearchRequest()
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    @objc func makeSearchRequest() {
        if enteredText == "" {
            return
        }
        networkManager.fetchForecast(city: enteredText) { (weatherResult, error) in
            if let error = error {
                DispatchQueue.main.async {
                    Service.showAlert(on: self, style: .alert, title: "Fetching weather error", message: error.localizedDescription)
                }
            }
            if let result = weatherResult {
                self.forecasts = result.forecast.forecasts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastDayCell", for: indexPath) as? ForecastDayTableViewCell else {
            return UITableViewCell()
        }
        
        let forecastDay = forecasts[indexPath.row]
        cell.forecastDay = forecastDay
        return cell
    }
    
}
