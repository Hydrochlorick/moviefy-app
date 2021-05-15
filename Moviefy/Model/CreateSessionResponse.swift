//
//  CreateSessionResponse.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/15/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

struct CreateSessionResponse: Codable {
    let success: Bool
    let session_id: String
}
