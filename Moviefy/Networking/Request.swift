//
//  Request.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/6/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum Route: String {
    case movies = "discover/movie"
}

struct Request {
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Bearer": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNTY3NjRhZjU1NjE2MTdmOWQ4NTBhYTIyMWVlNjQxOSIsInN1YiI6IjYwOTFiYWNjM2ZlNzk3MDA1NzE1NDRlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.svoucgvBx93wBAFMi7xuolHmr0NQTSsAjH8x_TcnEJg"
    ]
    
    static func configureRequest(from route: Route, with parameters: [String: Any], and method: HTTPMethod, contains body: Data?) throws -> URLRequest {
        // Safely create valid URL or return error
        guard let url = URL(string: "https://api.themoviedb.org/3/\(route.rawValue)") else { fatalError("Error while unwrapping URL") }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: [String: Any]?, headers: [String: String]?, request: inout URLRequest) throws {
        do {
            if let headers = headers, let parameters = parameters {
                try Encoder.encodeParameters(for: &request, with: parameters)
                try Encoder.setHeaders(for: &request, with: headers)
            }
        } catch {
                throw NetworkError.encodingFailed
        }
    }
}

