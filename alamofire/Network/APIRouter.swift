//
//  APIRouter.swift
//  alamofire
//
//  Created by youngseo on 2021/07/24.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation
import Alamofire

class APIRouter: URLRequestConvertible {
    
    enum APIType {
        case auth
        case service
        
        var baseURL: String {
            switch self {
            case .auth:
                switch enviroment {
                case .dev: return "https://auth.dev"
                case .stage: return "https://auth.dev"
                case .real: return "https://auth.real"
                }
            case .service:
                return "https://httpbin.org"
            }
        }
    }
    
    var path: String
    var httpMethod: HTTPMethod
    var parameters: Data?
    var apiType: APIType
    
    
    init(path: String, httpMethod: HTTPMethod? = .get, parameters: Data? = nil, apiType: APIType = .service) {
        self.path = path
        self.httpMethod = httpMethod ?? .get
        self.parameters = parameters
        self.apiType = apiType
    }
    
    func asURLRequest() throws -> URLRequest {
        // 1. base URL + path
        let fullURL = apiType.baseURL + path
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlCompoenet = URLComponents(string: encodedURL)!
        
        // 2. get> query parmeter 추가
        if httpMethod == .get, let params = parameters {
            if let dictionary = try? JSONSerialization.jsonObject(with: params, options: []) as? [String:Any] {
                var queries = [URLQueryItem]()
                for (name, value) in dictionary {
                    let encodedValue = "\(value)".addingPercentEncodingForRFC3986()
                    let queryItem = URLQueryItem(name: name, value: encodedValue)
                    queries.append(queryItem)
                }
                urlCompoenet.percentEncodedQueryItems = queries
            }
        }
        
        // 3. request 생성
        var request = try URLRequest(url: urlCompoenet.url!, method: httpMethod)
        
        // 4. post> json parameter 추가
        if httpMethod == .post, let params = parameters {
            request.httpBody = params
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // 5. header 추가
//        if hasHeader {
//            var headers = [String: String]()
//            headers["Authorization"] = "toekn " + accessToken
//            urlRequest.allHTTPHeaderFields = headers
//        }
        
        // 6. print to console
        print("[REQUEST]")
        print("URL: \(request.url?.absoluteString ?? "nil")")
        print("Body: \(request.httpBody?.toPrettyPrintedString ?? NSString("nil"))")
        
        return request
    }
    
}

