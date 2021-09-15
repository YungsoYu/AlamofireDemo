//
//  AlamofireService.swift
//  alamofire
//
//  Created by youngseo on 2021/09/07.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {
  static let shared = APIManager()

  let session: Session = {
    let configuration = URLSessionConfiguration.af.default

    configuration.timeoutIntervalForRequest = 30
    let apiLogger = APIEventLogger()
    let interceptor = AuthInterceptor()

    return Session(
      configuration: configuration,
      interceptor: interceptor,
      eventMonitors: [apiLogger])
  }()
}


