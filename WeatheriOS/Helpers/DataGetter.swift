//
//  DataGetter.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

class DataGetter {

    enum HTTPError: Error {
        case non200StatusCode
        case noData
    }
    
    func fetchData(with request: URLRequest, requestID: String? = nil, completion: @escaping (String?, Data?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(requestID, nil, error)
                return
            } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("non 200 http response: \(response.statusCode)")
                let myError = HTTPError.non200StatusCode
                completion(requestID, nil, myError)
                return
            }
            
            guard let data = data else {
                completion(requestID, nil, HTTPError.noData)
                return
            }
            completion(requestID, data, nil)
        }.resume()
    }
}
