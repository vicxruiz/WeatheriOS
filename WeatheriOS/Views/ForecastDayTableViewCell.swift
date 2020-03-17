//
//  ForecastDayTableViewCell.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

class ForecastDayTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var averageTempLabel: UILabel!
    
    var forecastDay: ForecastDay? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let forecastDay = forecastDay else {
            print("no forecast day")
            return
        }
        //descriptionLabel.text = forecastDay.day.condition.text
        averageTempLabel.text = "\(forecastDay.day.avgTemp)"
        dayLabel.text = forecastDay.date
    }
}

