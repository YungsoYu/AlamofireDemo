//
//  PostResponse.swift
//  alamofire
//
//  Created by youngseo on 2021/07/23.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation

struct HttpbinResponse: Decodable {
    var url: String?
    var json: UserInfo?
}
