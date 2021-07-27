//
//  Extension.swift
//  alamofire
//
//  Created by youngseo on 2021/07/26.
//  Copyright © 2021 youngseo. All rights reserved.
//

import Foundation

extension Data {
    var toPrettyPrintedString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}

extension Encodable {
    var toData: Data? {
        guard let data: Data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }
}

extension String {
    // percent encode by encoding except alphanumeric + unreserved special charcter(-._~/?)
    func addingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
