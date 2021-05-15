//
//  APIClient.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/6/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

struct APIClient {
    static let shared = APIClient()
    let session = URLSession(configuration: .default)
    
    let parameters = [
        "sort_by": "popularity.desc",
        "api_key": "d56764af5561617f9d850aa221ee6419"
    ]
    
    let justApiKey = [
        "api_key": "d56764af5561617f9d850aa221ee6419"
    ]
    
    func getImageConfiguration(_ completion: @escaping (Result<MovieDBConfiguration>) -> ()) {
        // Do statement to introduce a new scope and catch errors from it
        do {
            // Return a GET request for the /configuration endpoint with the api key as a parameter
            let request = try Request.configureRequest(from: .config, with: justApiKey, and: .get, contains: nil)
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse, let data = data {
                    let result = Response.handleResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(MovieDBConfiguration.self, from: data)
                        completion(Result.success(result!))
                    case let .failure(responseError):
                        print(responseError)
                        return
                    }
                }
            }.resume()
        } catch {
            fatalError(NetworkError.badRequest.rawValue)
        }
    }
    
    func getPopularMovies(_ completion: @escaping (Result<[Movie]>) -> ()) {
        do {
            // Create request
            let request = try Request.configureRequest(from: .movies, with: parameters, and: .get, contains: nil)
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse, let data = data {
                    let result = Response.handleResponse(for: response)
                    switch result {
                    case .success:
                        // Decode if successful
                        let result = try? JSONDecoder().decode(MovieApiResponse.self, from: data)
                        completion(Result.success(result!.movies))
                    case let .failure(responseError):
                        print(responseError)
                        return
                    }
                }
            }.resume()
        } catch {
            completion(Result.failure(NetworkError.badRequest))
        }
    }
}
