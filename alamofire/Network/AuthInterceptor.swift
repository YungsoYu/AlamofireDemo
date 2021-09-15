//
//  AuthInterCeptor.swift
//  alamofire
//
//  Created by youngseo on 2021/09/14.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation
import Alamofire

class AuthInterceptor: RequestInterceptor {
    //1
    let retryLimit = 0
    let retryDelay: TimeInterval = 0
    //2
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        if let token = TokenStorage.shared.accessToken {
            urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
    //3
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
    
//        refreshToken { result in
//            switch result {
//            case .success(let token):
//                // ⭐️
//                TokenStorage.shared.accessToken = token
//                if request.retryCount < retryLimit {
//                    completion(.retryWithDelay(retryDelay))
//                }
//                // ⭐️
//            case .failure(let error):
//                completion(.doNotRetryWithError(error))
//            }
//        }
    }
}
