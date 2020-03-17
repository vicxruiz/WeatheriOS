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
