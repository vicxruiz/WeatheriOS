//
//  RequestManager.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

class RequestManager {
    func makeRequestWithQuery(pathURL: URL, queryItemDict: [String:String], method: HTTPMethod) -> URLRequest? {
        var components = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)
        for pair in queryItemDict {
            let queryItem = URLQueryItem(name: pair.key, value: pair.value)
            components?.queryItems?.append(queryItem)
        }
        guard let url = components?.url else { return nil }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
