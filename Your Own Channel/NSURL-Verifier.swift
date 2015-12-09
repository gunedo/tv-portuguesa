//
//  URLVerifier.swift
//  LiveTVStream
//
//  Created by Markus Schalk on 03.12.15.
//  Copyright © 2015 Markus Schalk. All rights reserved.
//

import Foundation

extension NSURL {
    static func verifyUrlString(urlString: String?)->Bool {
        if let urlString = urlString {
            let url = NSURL(string: urlString)!
            let request = NSURLRequest(URL: url)
            if NSURLConnection.canHandleRequest(request) {
                return true
            }
        }
        return false
    }
}