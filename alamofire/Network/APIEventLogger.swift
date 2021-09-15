//
//  APILogger.swift
//  alamofire
//
//  Created by youngseo on 2021/09/14.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation
import Alamofire

class APIEventLogger: EventMonitor {
  //1
  let queue = DispatchQueue(label: "com.myCompany.myProject.networklogger")
  //2
  func requestDidFinish(_ request: Request) {
    print("⭐️Reqeust LOG")
    print(request.description)
    
    print(
      "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
        + "Method: " + (request.request?.httpMethod ?? "") + "\n"
        + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
    )
    print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
    print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
  }
  //3
  func request<Value>(
    _ request: DataRequest,
    didParseResponse response: DataResponse<Value, AFError>
  ) {
    print("⭐️RESPONSE LOG")
    print(
      "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
        + "Result: " + "\(response.result)" + "\n"
        + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
        + "Data: \(response.data?.toPrettyPrintedString ?? "")"
    )
  }
}

