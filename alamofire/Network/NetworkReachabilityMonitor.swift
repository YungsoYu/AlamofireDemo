//
//  NetworkReachabilityMonitor.swift
//  alamofire
//
//  Created by youngseo on 2021/09/14.
//  Copyright © 2021 youngseo. All rights reserved.
//

import UIKit
import Alamofire

class NetworkReachabilityMonitor {
  static let shared = NetworkReachabilityMonitor()
  let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
  let offlineAlertController: UIAlertController = {
    UIAlertController(title: "인터넷 연결 끊김", message: "인터넷 연결을 확인해주세요.", preferredStyle: .alert)
  }()

  func startNetworkMonitoring() {
    reachabilityManager?.startListening { [self] status in
      switch status {
      case .notReachable:
        showOfflineAlert()
      case .reachable(.cellular):
        dismissOfflineAlert()
      case .reachable(.ethernetOrWiFi):
        dismissOfflineAlert()
      case .unknown:
        print("Unknown network state")
      }
    }
  }

  private func showOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.present(offlineAlertController, animated: true, completion: nil)
  }

  private func dismissOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    offlineAlertController.dismiss(animated: true, completion: nil)
  }
}
