//
//  Encoder.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/6/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

public struct Encoder {
    
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: [String: Any]) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL}
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
    
    static func setHeaders(for urlRequest: inout URLRequest, with headers: [String: String]) throws {
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
