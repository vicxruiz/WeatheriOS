//
//  NetworkManager.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class NetworkManager {
    
    //MARK: Network Enums
    
    enum Endpoints: String {
        case forecast = "forecast.json"
    }
    
    enum QueryItems: String {
        case apiKey = "key"
        case query = "q"
        case days = "days"
    }
    
    let dataGetter = DataGetter()
    let requestManager = RequestManager()
    let baseWeatherAPIURL = URL(string: "http://api.weatherapi.com/v1")!
    let weatherAPIKey = "8a72de8d61234663a10151810201703"
    let numDays = 10
    
    func fetchForecast(city: String, completion: @escaping (Weather?,Error?) -> Void) {
        let forecastURL = baseWeatherAPIURL.appendingPathComponent("\(Endpoints.forecast.rawValue)")
        let request = requestManager.makeRequestWithQuery(pathURL: forecastURL, queryItemDict: [QueryItems.apiKey.rawValue:weatherAPIKey, QueryItems.query.rawValue:city, QueryItems.days.rawValue:String(numDays)], method: HTTPMethod.get)
        guard let unwrappedRequest = request else {
            completion(nil, HTTPError.noRequest)
            return
        }
        dataGetter.fetchData(with: unwrappedRequest) { (_, data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, HTTPError.noData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(Weather.self, from: data)
                completion(data, nil)
            } catch {
                print("error decoding data: \(error)")
                completion(nil, error)
            }
        }
    }
}
