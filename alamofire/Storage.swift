//
//  APIs.swift
//  alamofire
//
//  Created by youngseo on 2021/07/24.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation

enum Enviroment {
    case dev
    case stage
    case real
}

let enviroment: Enviroment = .dev

class TokenStorage {
    static let shared = TokenStorage()
    var accessToken: String?
    var refreshToken: String?
    
    init(accessToken: String? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

