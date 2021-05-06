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
}
