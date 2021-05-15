//
//  Account.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/15/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

struct Account: Codable {
    let id: Int
    let name: String?
    let username: String?
    
    var displayName: String {
        if let name = name, !name.isEmpty {
            return name
        }
        return username ?? "(Unknown)"
    }
}
