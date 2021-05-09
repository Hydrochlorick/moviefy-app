//
//  MovieDBConfiguration.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/9/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

struct ImagesData: Codable {
    let baseUrl: String
    let secureBaseUrl: String
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    
    private enum ImageCodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageCodingKeys.self)
        baseUrl = try container.decode(String.self, forKey: .baseUrl)
        secureBaseUrl = try container.decode(String.self, forKey: .secureBaseUrl)
        backdropSizes = try container.decode([String].self, forKey: .backdropSizes)
        logoSizes = try container.decode([String].self, forKey: .logoSizes)
        posterSizes = try container.decode([String].self, forKey: .posterSizes)
        profileSizes = try container.decode([String].self, forKey: .profileSizes)
        stillSizes = try container.decode([String].self, forKey: .stillSizes)
    }
}

struct MovieDBConfiguration: Codable {
    let images: ImagesData
    let changeKeys: [String]
    
    private enum configCodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: configCodingKeys.self)
        images = try container.decode(ImagesData.self, forKey: .images)
        changeKeys = try container.decode([String].self, forKey: .changeKeys)
    }
    
    static var current: MovieDBConfiguration?
}
