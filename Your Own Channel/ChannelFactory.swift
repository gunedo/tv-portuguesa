//
//  ChannelFactory.swift
//  LiveTVStream
//
//  Created by Markus Schalk on 03.12.15.
//  Copyright © 2015 Markus Schalk. All rights reserved.
//

import Foundation

class ChannelFactory {
    static func createChannel(name: String, urlString: String) -> Channel? {
        if NSURL.verifyUrlString(urlString) {
            return Channel(name: name, urlString: urlString)
        }
        return nil
    }
}