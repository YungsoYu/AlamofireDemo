//
//  ViewController.swift
//  alamofire
//
//  Created by youngseo on 2021/07/23.
//  Copyright © 2021 youngseo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var userInfo: UserInfo = {
        var userInfo = UserInfo()
        userInfo.userName = "yungso"
        userInfo.age = 20
        return userInfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        basicRequest()
//        getRequestByRouter()
//        postRequestByRouter()
        
        testAuth()
    }
    
    func testAuth() {
        let router = APIRouter(path: APIPath.postPractice, httpMethod: .post, parameters: userInfo.toData, apiType: .service)
        APIManager.shared.session.request(router).responseDecodable(of: HttpbinResponse.self, completionHandler: {(response: DataResponse<HttpbinResponse, AFError>) -> Void in
            switch response.result {
            case .success(let value):
                // do someting with value in view controller level
                break
            case .failure(let err):
                 print(err)
            }
        })
    }
    
    func basicRequest() {
        let params: Parameters = ["userName": "yungso",
                                  "age": 20]
        
        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: params).responseDecodable(of: HttpbinResponse.self, completionHandler: {(response: DataResponse<HttpbinResponse, AFError>) -> Void in
                    switch response.result {
                    case .success(let value):
                        print("[RESPONSE]")
                        print(response.data?.toPrettyPrintedString)
                    case .failure(let err):
                        print("API Failure")
                        print(err)
                    }
                   })
    }
    
    func getRequestByRouter() {
        let router = APIRouter(path: APIPath.getPractice, httpMethod: .get, parameters: userInfo.toData, apiType: .service)
        AF.request(router).responseDecodable(of: HttpbinResponse.self, completionHandler: {(response: DataResponse<HttpbinResponse, AFError>) -> Void in
            switch response.result {
            case .success(let value):
                print("[RESPONSE]")
                print("URL: \(value.url ?? "")")
                print("Response Data: \(response.data?.toPrettyPrintedString ?? "")")
            case .failure(let err):
                print("API Failure")
                 print(err)
            }
        })
    }
    
    func postRequestByRouter() {
        let router = APIRouter(path: APIPath.postPractice, httpMethod: .post, parameters: userInfo.toData, apiType: .service)
        AF.request(router).responseDecodable(of: HttpbinResponse.self, completionHandler: {(response: DataResponse<HttpbinResponse, AFError>) -> Void in
            switch response.result {
            case .success(let value):
                print("[RESPONSE]")
                print("URL: \(value.url ?? "")")
                print("json body: \(value.json ?? UserInfo())")
                print("Response Data: \(response.data?.toPrettyPrintedString ?? "")")
            case .failure(let err):
                print("API Failure")
                print(err)
            }
        })
    }
    
}
